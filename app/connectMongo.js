const mongoose = require("mongoose");

const connectDB = async () => {
  const uri = process.env.MONGO_URI;

  if (!uri) {
    throw new Error("MONGO_URI is not defined");
  }

  let retries = 5;

  while (retries) {
    try {
      await mongoose.connect(uri);
      console.log("✅ MongoDB connected");
      break;
    } catch (err) {
      retries -= 1;
      console.error("❌ MongoDB connection failed. Retrying...", err.message);
      await new Promise((res) => setTimeout(res, 5000));
    }
  }

  if (!retries) {
    process.exit(1);
  }
};

module.exports = connectDB;
