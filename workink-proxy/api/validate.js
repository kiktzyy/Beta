import fetch from "node-fetch";

export default async function handler(req, res) {
  const { token } = req.query;
  if (!token) {
    return res.status(400).json({ error: "Token is required" });
  }

  try {
    const response = await fetch(`https://work.ink/_api/v2/token/isValid/${token}`);
    const data = await response.json();
    res.status(200).json(data);
  } catch (error) {
    res.status(500).json({ error: "Proxy fetch failed" });
  }
}
