require "../../spec_helper"

describe "belongs_to" do
  it "provides a getter for the foreign entity" do
    teacher = Teacher.new
    teacher.name = "Test teacher"
    teacher.save

    klass = Klass.new
    klass.name = "Test klass"
    klass.teacher_id = teacher.id
    klass.save

    klass.teacher.id.should eq teacher.id
  end

  it "provides a setter for the foreign entity" do
    teacher = Teacher.new
    teacher.name = "Test teacher"
    teacher.save

    klass = Klass.new
    klass.name = "Test klass"
    klass.teacher = teacher
    klass.save

    klass.teacher_id.should eq teacher.id
  end

  it "supports custom types for the join" do
    book = Book.new
    book.name = "Screw driver"
    book.save

    review = BookReview.new
    review.book = book
    review.body = "Best book ever!"
    review.save

    review.book.name.should eq "Screw driver"
  end

  it "supports custom method name" do
    author = Person.new
    author.name = "John Titor"
    author.save

    book = Book.new
    book.name = "How to Time Traveling"
    book.author = author
    book.save

    book.author.name.should eq "John Titor"
  end

  it "supports both custom method name and custom types for the join" do
    publisher = Company.new
    publisher.name = "Amber Framework"
    publisher.save

    book = Book.new
    book.name = "Introduction to Granite"
    book.publisher = publisher
    book.save

    book.publisher.name.should eq "Amber Framework"
  end
end
