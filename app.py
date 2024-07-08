from flask import Flask, request, jsonify, render_template, redirect, url_for
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.sql import func

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+mysqlconnector://root:onedirection@localhost/artify"
db = SQLAlchemy(app)

class Artist(db.Model):
    __tablename__ = 'artists'
    artistID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    dateOfBirth = db.Column(db.Date, nullable=False)
    biography = db.Column(db.Text)

class Artwork(db.Model):
    __tablename__ = 'artworks'
    artworkID = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    creationDate = db.Column(db.Date)
    description = db.Column(db.Text)
    price = db.Column(db.Numeric(10, 2))
    category = db.Column(db.String(255))
    artist_id = db.Column(db.Integer, db.ForeignKey('artists.artistID'))
    artist = db.relationship('Artist', backref='artworks')

class Customer(db.Model):
    __tablename__ = 'customers'
    customerID = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(255), nullable=False)
    phoneNumber = db.Column(db.String(15))
    email = db.Column(db.String(255))
    address = db.Column(db.Text)

class Sale(db.Model):
    __tablename__ = 'sales'
    saleID = db.Column(db.Integer, primary_key=True)
    saleDate = db.Column(db.Date)
    totalAmount = db.Column(db.Numeric(10, 2))

class Exhibition(db.Model):
    __tablename__ = 'exhibitions'
    exhibitionID = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255))
    startDate = db.Column(db.Date)
    endDate = db.Column(db.Date)
    location = db.Column(db.String(255))
    artworks = db.relationship('Artwork', secondary='bookings')

class Booking(db.Model):
    __tablename__ = 'bookings'
    bookingID = db.Column(db.Integer, primary_key=True)
    artworkID = db.Column(db.Integer, db.ForeignKey('artworks.artworkID'))
    exhibitionID = db.Column(db.Integer, db.ForeignKey('exhibitions.exhibitionID'))
    artwork = db.relationship('Artwork', backref='bookings')
    exhibition = db.relationship('Exhibition', backref='bookings')

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/insert_artist", methods=["GET", "POST"])
def insert_artist():
    if request.method == "POST":
        name = request.form["artist_name"]
        dateOfBirth = request.form["dateOfBirth"]
        biography = request.form["biography"]
        new_artist = Artist(name=name, dateOfBirth=dateOfBirth, biography=biography)
        db.session.add(new_artist)
        db.session.commit()
        return redirect(url_for('home'))
    return render_template("insert_artist.html")

@app.route("/update_artwork_price", methods=["GET", "POST"])
def update_artwork_price():
    if request.method == "POST":
        artwork_id = request.form["artwork_id"]
        new_price = request.form["new_price"]
        artwork = Artwork.query.get(artwork_id)
        if artwork:
            artwork.price = new_price
            db.session.commit()
            return redirect(url_for('home'))
    return render_template("update_artwork_price.html")

@app.route("/delete_customer", methods=["GET", "POST"])
def delete_customer():
    if request.method == "POST":
        customer_id = request.form["customer_id"]
        customer = Customer.query.get(customer_id)
        if customer:
            db.session.delete(customer)
            db.session.commit()
            return redirect(url_for('home'))
    return render_template("delete_customer.html")

@app.route("/average_artwork_price", methods=["GET"])
def average_artwork_price():
    artworks = Artwork.query.all()
    if artworks:
        total_price = sum(artwork.price for artwork in artworks)
        average_price = total_price / len(artworks)
        return render_template("average_artwork_price.html", average_price=average_price)
    return render_template("average_artwork_price.html", average_price="No artworks found")

@app.route("/artworks_with_artist", methods=["GET"])
def artworks_with_artist():
    artworks = db.session.query(Artwork, Artist).join(Artist, Artwork.artist_id == Artist.artistID).with_entities(Artwork, Artist).all()
    return render_template("artworks_with_artist.html", artworks=artworks)

@app.route("/active_exhibitions", methods=["GET"])
def active_exhibitions():
    today = datetime.today().date()
    exhibitions = Exhibition.query.filter(Exhibition.startDate <= today, Exhibition.endDate >= today).all()
    return render_template("active_exhibitions.html", exhibitions=exhibitions)

@app.route("/customers_with_more_than_3_artworks", methods=["GET"])
def customers_with_more_than_3_artworks():
    customers = Customer.query.join(Sale).group_by(Customer.customerID).having(func.count(Sale.saleID) > 3).all()
    return render_template("customers_with_more_than_3_artworks.html", customers=customers)

@app.route("/exhibitions_with_artwork_count", methods=["GET"])
def exhibitions_with_artwork_count():
    exhibitions = Exhibition.query.join(Booking).join(Artwork).group_by(Exhibition.exhibitionID).all()
    result = []
    for exhibition in exhibitions:
        artwork_count = len(exhibition.bookings)
        result.append({"title": exhibition.title, "artwork_count": artwork_count})
    return render_template("exhibitions_with_artwork_count.html", exhibitions=result)

if __name__ == "__main__":
    app.run(debug=True)
