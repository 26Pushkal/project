const express = require('express');
const bodyParser = require('body-parser');

// Initialize express app
const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Basic route
app.get('/', (req, res) => {
    res.send('Hello, welcome to our Node.js app!');
});

// Add two numbers (POST method)
app.post('/add', (req, res) => {
    const { num1, num2 } = req.body;

    if (typeof num1 !== 'number' || typeof num2 !== 'number') {
        return res.status(400).json({ error: 'Both num1 and num2 must be numbers.' });
    }

    const sum = num1 + num2;
    res.status(200).json({ result: sum });
});

// Multiply two numbers (POST method)
app.post('/multiply', (req, res) => {
    const { num1, num2 } = req.body;

    if (typeof num1 !== 'number' || typeof num2 !== 'number') {
        return res.status(400).json({ error: 'Both num1 and num2 must be numbers.' });
    }

    const product = num1 * num2;
    res.status(200).json({ result: product });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
