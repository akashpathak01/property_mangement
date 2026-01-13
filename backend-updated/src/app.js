const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const routes = require('./routes');

const app = express();

// Middleware
app.use(helmet());
app.use(cors()); // Configure this properly for production later
app.use(express.json());
app.use(morgan('dev'));

// Routes
app.use('/api', routes);
// app.use('/uploads', express.static('uploads')); // Removed for security

// Error Handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ status: 'error', message: 'Something went wrong!' });
});

module.exports = app;
