tests
testFailFast

	| mathFailureExplanation |

	mathFailureExplanation := 'An obvious math error'.
	checkerBuilder
		failFast;
		checking: [ :asserter | 
			asserter
				enforce: [ 2 > 3 ] because: mathFailureExplanation;
				enforce: [ self fail ] because: [ self fail ];
				enforce: [ self fail ] because: [ self fail ] ].

	self
		should: [ checkerBuilder buildAndCheck ]
		raise: AssertionFailed
		withExceptionDo: [ :exception | 
			self
				assert: exception messageText equals: mathFailureExplanation;
				assertCollection: exception failures hasSameElements: {mathFailureExplanation} ]