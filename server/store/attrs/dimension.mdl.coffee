
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

sname = 'Dimension'

validators = require('../validators')
units_of_length = ['MM', 'CM', 'M']


# group landscape
# 100 x 80
# 120 x 100
# 160 x 120

# group portrait
# 80 x 100
# 100 x 120
# 120 x 160

# groupt quadratic
# 100 x 100
# 200 x 200

schema = new Schema(
	group:
		type: 		String
		enum: 		['landscape', 'portrait', 'quadratic', 'rectangular', 'cubic']
		required: 	true

	width:
		type: Number
		validate: validators.number_gt_zero

	height:
		type: Number
		validate: validators.number_gt_zero

	depth:
		type: Number
		validate: validators.number_gt_zero

	width_unit:
		type: String
		enum: units_of_length
		default: 'CM'

	height_unit:
		type:
			type: String
			enum: units_of_length
			default: 'CM'

	depth_unit:
		type: String
		enum: units_of_length
		default: 'CM'
)

# schema.pre 'save', (next) ->
# 	# ensure unique values for group
# 	c = @

# 	cat_mdl = c.model( sname )


# 	cat_mdl.findOne {
# 		group: c.group
# 		width: c.width
# 		height: c.height

# 	}, (err, dim) ->

# TODO: check this: submissionSchema.index({ email: 1, sweepstakes_id: 1 }, { unique: true });


module.exports = mongoose.model(sname, schema)