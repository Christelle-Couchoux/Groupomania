const multer = require('multer');

// dictionnary to add file extension

const MIME_TYPES = {
    'image/jpg': 'jpg',
    'image/jpeg': 'jpg',
    'image/png': 'png',
    'image/gif': 'gif'
};

const storage = multer.diskStorage({
    // save in repo images
    destination: (req, file, callback) => {
    callback(null, 'images');
    },
    // give unique file name 'original_name + timestamp + . + extension'
    filename: (req, file, callback) => {
        const name = file.originalname.split(' ').join('_');
        const extension = MIME_TYPES[file.mimetype];
        callback(null, name + Date.now() + '.' + extension);
    }
});

module.exports = multer({storage: storage}).single('image'); 
// if 'image' here, name input type file must be 'image', and must be formData.append('image', this.file) 
