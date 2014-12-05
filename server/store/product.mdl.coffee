_ = require('lodash')
q = require('q')
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

# mongodb = require('mongodb')
# ObjectID = mongodb.ObjectID

schemaName = 'Product'

errLog = require('winston').loggers.get( 'error' )
vals = require('./validators')


schema = new Schema(

	title :
		type : 		String
		required : 	true
		index: 		true

	ean :
		type : 		String
		required : 	true
		unique : 	true

	rel:
		type: String
		enum: ['parent', 'child']
		# required: true
		# default: 'parent'

	vars: [ObjectId] # variants

	imgs:
		type: [ require('./schemas/image.schm') ]

	# todo: validate attrs
	attrs:
		type: []
		default: []
		validate: [(val) ->
			# ensure unique values
			{
				type: 'Color'
				ref: ObjectId
			}


			return true
		, 'attribute should be unique' ]
		# type: {} #[require('./schemas/attr.schm')]
		# default: []

		# type: {
		# 	ref: 'Dimension'
		# }

	price:
		type: {}
		validate: [ vals.price, 'Invalid price object' ]
		required: true

	cats:
		default: []
		type: [{
			type: ObjectId
			ref: 'Category'
		}]
							# categories TODO: format?

	tags : [String]					# tags

	rats : []					# ratings

	cdate :		# create date
		type : 		Date
		default : 	Date.now

	udate : 	# update date
		type : 		Date
		default : 	Date.now
)


# CUSTOM STATIC METHODS
schema.statics =

	findByColorKey: (colorKey, cb) ->
		query =
			colors:
				$elemMatch:
					key: colorKey

		@find query, cb


	isPresent: ( pid ) ->
		c = @

		# if !(pid instanceof ObjectID)
		# 	q.fcall -> throw new Error("pid is not ObjectID")

		def = q.defer()
		c.model( schemaName ).findOne {_id: pid}, (err, prod) ->
			if err
				return def.reject( err )

			if prod is null
				def.reject( pid )
			else
				def.resolve( prod )

		return def.promise


schema.pre 'save', (next) ->
	c = @

	Category = mongoose.model('Category')

	# add product to default categories
	if not _.isArray(c.cats) or c.cats.length is 0
		Category.find {type:'default'}, (err, cats) ->
			return errLog.error( err ) if err

			bulk = Category.collection.initializeUnorderedBulkOp()
			_.each cats, (cat) ->
				bulk.find({_id:cat._id}).updateOne( {$addToSet: {items: c._id} } )
				c.cats.push( cat._id )
			bulk.execute (err, rep) ->
				errLog.error( err ) if err
				next()

	# push product to categories
	else
		bulk = Category.collection.initializeUnorderedBulkOp()
		_.each c.cats, (catId) -> bulk.find({_id:catId}).updateOne( {$addToSet: {items: c._id} } )
		bulk.execute (err, rep) ->
			errLog.error( err ) if err
			next()


# TODO: on remove product remove its id from categories items lists
# schema.statics =

# 	safeFindByIdAndRemove: (id, cb) ->
# 		c = @
# 		model = c.model(schemaName)

# 		model.findOne {_id:id}, (err, p) ->
# 			return cb?(err) if err








module.exports = mongoose.model(schemaName, schema)

