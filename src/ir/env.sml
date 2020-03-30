structure Trans = Translate

structure Env : ENV =
struct

type access = unit
type ty = Types.ty

	      
datatype enventry = VarEntry of {access: Trans.access, ty : ty}
		      | FunEntry of {level: Trans.level, label: Trans.level, formals: ty list, result: ty}

val base_tenv = let val map : (ty Symbol.table) = Symbol.empty
		    val tyList = [(Symbol.symbol("string"), Types.STRING), (Symbol.symbol("int"), Types.INT)]
		    fun addToMap ((sym, ty), curMap) = Symbol.enter(curMap, sym, ty)
		in
		    foldl addToMap map tyList
		end

val base_venv = let val map : (enventry Symbol.table) = Symbol.empty
		    val varList = [(Symbol.symbol("exit"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.INT], result = Types.UNIT}),
				   (Symbol.symbol("ord"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.STRING], result = Types.INT}),
				   (Symbol.symbol("chr"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.INT], result = Types.STRING}),
				   (Symbol.symbol("not"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.INT], result = Types.INT}),
				   (Symbol.symbol("size"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.STRING], result = Types.INT}),
				   (Symbol.symbol("print"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.STRING], result = Types.UNIT}),
				   (Symbol.symbol("substring"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.STRING, Types.INT, Types.INT], result = Types.STRING}),
				   (Symbol.symbol("concat"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [Types.STRING, Types.STRING], result = Types.STRING}),
				   (Symbol.symbol("flush"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [], result = Types.UNIT}),
				   (Symbol.symbol("getchar"), FunEntry{level = Trans.outermost, label = Temp.newLabel(), formals = [], result = Types.STRING})
				  ]
		    fun addToMap ((sym, ty), curMap) = Symbol.enter(curMap, sym, ty)
		in
		    foldl addToMap map varList
		end
end
