import mongoose from "mongoose";

export const connectDB = async (): Promise<void> => {
  const uri = process.env.MONGO_URI;

  if (!uri) {
    throw new Error("MONGO_URI is not defined");
  }

  let retries = 5;

  while (retries > 0) {
    try {
      await mongoose.connect(uri);
      console.log("MongoDB connected");
      return;
    } catch (error) {
      retries--;
      console.error("❌ MongoDB connection failed. Retrying...");
      await new Promise((res) => setTimeout(res, 5000));
    }
  }

  console.error("MongoDB connection failed after retries");
  process.exit(1);
};
