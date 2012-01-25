class this.OpCodes
      
  constructor : (thread) ->    
  
    @[0] = new OpCode('nop', 'Does nothing', (frame) -> yes )
    
    @[1] = new OpCode('aconst_null', 'Push null object reference', (frame) -> 
      frame.op_stack.push(null)
    )
    @[2] = new OpCode('iconst_m1', 'Push int constant -1', (frame) -> 
      frame.op_stack.push(-1)
    )
    @[3] = new OpCode('iconst_0', 'Push int constant 0', (frame) -> 
      frame.op_stack.push(0)
    )
    @[4] = new OpCode('iconst_1', 'Push int constant 1', (frame) -> 
      frame.op_stack.push(1)  
    )
    @[5] = new OpCode('iconst_2', 'Push int constant 2', (frame) -> 
      frame.op_stack.push(2)
    )
    @[6] = new OpCode('iconst_3', 'Push int constant 3', (frame) -> 
      frame.op_stack.push(3)
    )
    @[7] = new OpCode('iconst_4', 'Push int constant 4', (frame) -> 
      frame.op_stack.push(4)
    )
    @[8] = new OpCode('iconst_5', 'Pushes int constant 5 to the frame.op_stack.', (frame) -> 
      frame.op_stack.push(5)
    )
    @[9] = new OpCode('lconst_0', 'Push long constant 0', (frame) -> 
      frame.op_stack.push(new CONSTANT_long(0))
      frame.op_stack.push(new CONSTANT_long(0))
    )
    @[10] = new OpCode('lconst_1', 'Push long constant 1', (frame) -> 
      frame.op_stack.push(new CONSTANT_long(1))
      frame.op_stack.push(new CONSTANT_long(1))
    )
    @[11] = new OpCode('fconst_0', 'Push float 0', (frame) -> 
      frame.op_stack.push(new CONSTANT_float())
    )
    @[12] = new OpCode('fconst_1', 'Push float 1', (frame) -> 
      frame.op_stack.push(new CONSTANT_float(1.0))
    )
    @[13] = new OpCode('fconst_2', 'Push float 2', (frame) -> 
      frame.op_stack.push(new CONSTANT_float(2.0))
    )
    @[14] = new OpCode('dconst_0', 'Push double 0', (frame) -> 
      frame.op_stack.push(new CONSTANT_double(0.0))
      frame.op_stack.push(new CONSTANT_double(0.0))
    )
    @[15] = new OpCode('dconst_1', 'Push double 1', (frame) -> 
      frame.op_stack.push(new CONSTANT_double(1.0))
      frame.op_stack.push(new CONSTANT_double(1.0))
    )
    @[16] = new OpCode('bipush', 'Push 8 bit signed integer', (frame) -> 
      frame.op_stack.push(frame.method_stack[++thread.pc])
    )
    @[17] = new OpCode('sipush', 'Push short', (frame) -> 
      byte1 = @getIndexByte(1, frame, thread)
      byte2 = @getIndexByte(2, frame, thread)
      short = (byte1 << 8) | byte2
      frame.op_stack.push(short)
    )
    @[18] = new OpCode('ldc', 'Push item from constant pool', (frame) -> 
      item = @getIndexByte(1, frame, thread)
      while typeof (item = @fromClass(item, thread)) is 'number' 
        continue
     
      if item == 'undefined'
        throw 'JVM_Error: Undefined item on stack'
      # TODO check item is valid
      frame.op_stack.push(item)
    )
    @[19] = new OpCode('ldc_w', 'Push item from constant pool (wide index)', (frame) -> 
      item = @constructIndex(frame, thread)
      while typeof (item = @fromClass(item, thread)) is 'number' 
        continue
      # TODO check item is valid
      frame.op_stack.push(item)
    )
    @[20] = new OpCode('ldc2_w', 'Push long or double from constant pool (wide index)', (frame) -> 
      index = @constructIndex(frame, thread)
      item = thread.current_class.constant_pool[index]
      # TODO check item is long or double
      frame.op_stack.push(item)
    )
    @[21] = new OpCode('iload', 'Load int from local variable', (frame) -> 
      frame.op_stack.push(frame.locals[@getIndexByte(1, frame, thread)])  
    )
    @[22] = new OpCode('lload', 'Load long from local variable', (frame) ->
      frame.op_stack.push(frame.locals[@getIndexByte(1, frame, thread)])
      frame.op_stack.push(frame.locals[@getIndexByte(1, frame, thread)])
    )
    @[23] = new OpCode('fload', 'Load float from local variable', (frame) -> 
      frame.op_stack.push(frame.locals[@getIndexByte(1, frame, thread)])
    )
    @[24] = new OpCode('dload', 'Load double from local variable', (frame) -> 
      frame.op_stack.push(frame.locals[@getIndexByte(1, frame, thread)])
    )
    @[25] = new OpCode('aload', 'Load reference from local variable', (frame) -> 
      frame.op_stack.push(frame.locals[@getIndexByte(1, frame, thread)])
    )
    @[26] = new OpCode('iload_0', 'Load int from local variable 0', (frame) -> 
      frame.op_stack.push(frame.locals[0])
    )
    @[27] = new OpCode('iload_1', 'Load int from local variable 1', (frame) -> 
      frame.op_stack.push(frame.locals[1])
    )
    @[28] = new OpCode('iload_2', 'Load int from local variable 2', (frame) -> 
      frame.op_stack.push(frame.locals[2])
    )
    @[29] = new OpCode('iload_3', 'Load int from local variable 3', (frame) -> 
      frame.op_stack.push(frame.locals[3])
    )
    @[30] = new OpCode('lload_0', 'Load long from local variable 0', (frame) -> 
      frame.op_stack.push(frame.locals[0])
    )
    @[31] = new OpCode('lload_1', 'Load long from local variable 1', (frame) -> 
      frame.op_stack.push(frame.locals[1])
    )
    @[32] = new OpCode('lload_2', 'Load long from local variable 2', (frame) -> 
      frame.op_stack.push(frame.locals[2])
    )
    @[33] = new OpCode('lload_3', 'Load long from local variable 3', (frame) -> 
      frame.op_stack.push(frame.locals[3])
    )
    @[34] = new OpCode('fload_0', 'Load float from local var 0', (frame) -> 
      frame.op_stack.push(frame.locals[0])
    )
    @[35] = new OpCode('fload_1', 'Load float from local var 1', (frame) -> 
      frame.op_stack.push(frame.locals[1])
    )
    @[36] = new OpCode('fload_2', 'Load float from local var 2', (frame) -> 
      frame.op_stack.push(frame.locals[2])
    )
    @[37] = new OpCode('fload_3', 'Load float from local var 3', (frame) -> 
      frame.op_stack.push(frame.locals[3])
    )
    @[38] = new OpCode('dload_0', 'Load double from local variable', (frame) -> 
      halfDouble = frame.locals[0]
      secHalfDouble = frame.locals[1]  
      frame.op_stack.push(halfDouble)
      frame.op_stack.push(secHalfDouble)
      # TODO Maybe use IEEE floating point doubles...?      
    )
    @[39] = new OpCode('dload_1', 'Load double from local variable', (frame) -> 
      halfDouble = frame.locals[0]
      secHalfDouble = frame.locals[1]  
      frame.op_stack.push(halfDouble)
      frame.op_stack.push(secHalfDouble)
    )
    @[40] = new OpCode('dload_2', 'Load double from local variable', (frame) -> 
      halfDouble = frame.locals[0]
      secHalfDouble = frame.locals[1]  
      frame.op_stack.push(halfDouble)
      frame.op_stack.push(secHalfDouble)
    )
    @[41] = new OpCode('dload_3', 'Load double from local variable', (frame) -> 
      halfDouble = frame.locals[0]
      secHalfDouble = frame.locals[1]  
      frame.op_stack.push(halfDouble)
      frame.op_stack.push(secHalfDouble)
    )
    @[42] = new OpCode('aload_0', 'Load reference from local variable 0', (frame) -> 
      frame.op_stack.push(frame.locals[0])
    )
    @[43] = new OpCode('aload_1', 'Load reference from local variable 1', (frame) -> 
      frame.op_stack.push(frame.locals[1])
    )
    @[44] = new OpCode('aload_2', 'Load reference from local variable 2', (frame) -> 
      frame.op_stack.push(frame.locals[2])
    )
    @[45] = new OpCode('aload_3', 'Load reference from local variable 3', (frame) -> 
      frame.op_stack.push(frame.locals[3])
    )
    @[46] = new OpCode('iaload', 'Load int from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if arrayref is null
        athrow('NullPointerException')
      array = thread.RDA.heap[arrayref]
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      int = array[arrayindex]
      frame.op_stack.push(int)
    )
    @[47] = new OpCode('laload', 'Load long from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if arrayref is null
        athrow('NullPointerException')
      array = thread.RDA.heap[arrayref]
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      long = array[arrayindex]
      frame.op_stack.push(long)
    )
    @[48] = new OpCode('faload', 'Load float from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if arrayref is null
        athrow('NullPointerException')
      array = thread.RDA.heap[arrayref]
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      float = array[arrayindex]
      frame.op_stack.push(float)
    )
    @[49] = new OpCode('daload', 'Load double from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if arrayref is null
        athrow('NullPointerException')
      array = thread.RDA.heap[arrayref]
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      double = array[arrayindex]
      frame.op_stack.push(double)
    )
    @[50] = new OpCode('aaload', 'Load reference from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      ref = thread.RDA.heap[arrayref][arrayindex]
      frame.op_stack.push(ref)
    )
    @[51] = new OpCode('baload', 'Load byte or boolean from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if not arrayref instanceof JVM_Reference
        athrow('RuntimeException')
        return false
      if arrayref == null
        athrow('NullPointerException')
        return false
      array = fromHeap(arrayref)
      if arrayindex >= array.length or arrayindex < 0
        athrow('ArrayIndexOutOfBounds')
        return false
      frame.op_stack.push(array[arrayindex])      
    )
    @[52] = new OpCode('caload', 'Load char from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if not arrayref instanceof JVM_Reference
        athrow('RuntimeException')
        return false
      if arrayref == null
        athrow('NullPointerException')
        return false
      array = fromHeap(arrayref)
      # array must be of type 'char' 
      if array.type != 'char'
        #do something..?
        # throw runtimeexception
        return false
      if arrayindex >= array.length or arrayindex < 0
        athrow('ArrayIndexOutOfBounds')
        return false
      frame.op_stack.push(array[arrayindex])
    )
    @[53] = new OpCode('saload', 'Load short from array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      if not arrayref instanceof JVM_Reference
        athrow('RuntimeException')
        return false
      if arrayref == null
        athrow('NullPointerException')
        return false
      array = fromHeap(arrayref)
      # array must be of type 'char' 
      if arrayindex >= array.length or arrayindex < 0
        athrow('ArrayIndexOutOfBounds')
        return false
      frame.op_stack.push(array[arrayindex])      
    )
    @[54] = new OpCode('istore', 'Store int into local variable', (frame) -> 
      index = @getIndexByte(1, frame, thread)
      int = frame.op_stack.pop()
      frame.locals[index] = int
    )
    @[55] = new OpCode('lstore', 'Store long into local variable', (frame) -> 
      index = @getIndexByte(1, frame, thread)
      long = frame.op_stack.pop()
      frame.locals[index] = long
    )
    @[56] = new OpCode('fstore', 'Store float into local variable', (frame) -> 
      index = @getIndexByte(1, frame, thread)
      float = frame.op_stack.pop()
      frame.locals[index] = float  
    )
    @[57] = new OpCode('dstore', 'Store double into local variable', (frame) -> 
      d = frame.op_stack.pop()
      d1 = frame.op_stack.pop()
      index = @getIndexByte(1, frame, thread)
      frame.locals[index] = d      
    )
    @[58] = new OpCode('astore', 'Store reference into local variable', (frame) -> 
      index = @getIndexByte(1, frame, thread)
      objectref = frame.op_stack.pop()
      # TODO objectref must be of type returnAddress or Reference
      # index must be a valid local index
      frame.locals[index] = objectref
    )
    @[59] = new OpCode('istore_0', 'Store int from opstack to local variable 0', (frame) -> 
      frame.locals[0] = frame.op_stack.pop()
    )
    @[60] = new OpCode('istore_1', 'Store int from opstack to local variable 1', (frame) -> 
      frame.locals[1] = frame.op_stack.pop()
    )
    @[61] = new OpCode('istore_2', 'Store int from opstack to local variable 2', (frame) -> 
      frame.locals[2] = frame.op_stack.pop()
    )
    @[62] = new OpCode('istore_3', 'Store int from opstack to local variable 3', (frame) -> 
      frame.locals[3] = frame.op_stack.pop()
    )
    @[63] = new OpCode('lstore_0', 'Store long into local variable 0', (frame) -> 
      frame.locals[0] = frame.op_stack.pop()
      frame.locals[1] = frame.op_stack.pop()
    )
    @[64] = new OpCode('lstore_1', 'Store long into local variable 1', (frame) -> 
      frame.locals[1] = frame.op_stack.pop()
      frame.locals[2] = frame.op_stack.pop()
    )
    @[65] = new OpCode('lstore_2', 'Store long into local variable 2', (frame) -> 
      frame.locals[2] = frame.op_stack.pop()
      frame.locals[3] = frame.op_stack.pop()
    )
    @[66] = new OpCode('lstore_3', 'Store long into local variable 3', (frame) -> 
      frame.locals[3] = frame.op_stack.pop()
      frame.locals[4] = frame.op_stack.pop()
    )
    @[67] = new OpCode('fstore_0', 'Store float into local variable 0', (frame) -> 
      frame.locals[0] = frame.op_stack.pop()
    )
    @[68] = new OpCode('fstore_1', 'Store float into local variable 1', (frame) -> 
      frame.locals[1] = frame.op_stack.pop()
    )
    @[69] = new OpCode('fstore_2', 'Store float into local variable 2', (frame) -> 
      frame.locals[2] = frame.op_stack.pop()
    )
    @[70] = new OpCode('fstore_3', 'Store float into local variable 3', (frame) -> 
      frame.locals[3] = frame.op_stack.pop()
    )
    @[71] = new OpCode('dstore_0', 'Store double to local var 0', (frame) -> 
      d = frame.op_stack.pop()
      d1 = frame.op_stack.pop()
      frame.locals[0] = d
      frame.locals[1] = d1
      yes
    )
    @[72] = new OpCode('dstore_1', 'Store double to local var 1', (frame) -> 
      d = frame.op_stack.pop()
      d1 = frame.op_stack.pop()
      frame.locals[1] = d
      frame.locals[2] = d1
      yes
    )
    @[73] = new OpCode('dstore_2', 'Store double to local var 2', (frame) -> 
      d = frame.op_stack.pop()
      d1 = frame.op_stack.pop()
      frame.locals[2] = d
      frame.locals[3] = d1
      yes
    )
    @[74] = new OpCode('dstore_3', 'Store double to local var 3', (frame) -> 
      d = frame.op_stack.pop()
      d1 = frame.op_stack.pop()
      frame.locals[3] = d
      frame.locals[4] = d1
      yes
    )
    @[75] = new OpCode('astore_0', 'Store reference into local var 0', (frame) -> 
      objectref = frame.op_stack.pop()
      frame.locals[0] = objectref
      yes
    )
    @[76] = new OpCode('astore_1', 'Store reference into local var 1', (frame) -> 
      objectref = frame.op_stack.pop()
      frame.locals[1] = objectref
      yes
    )
    @[77] = new OpCode('astore_2', 'Store reference into local var 2', (frame) -> 
      objectref = frame.op_stack.pop()
      frame.locals[2] = objectref
      yes
    )
    @[78] = new OpCode('astore_3', 'Store reference into local var 3', (frame) -> 
      objectref = frame.op_stack.pop()
      frame.locals[3] = objectref
      yes
    )
    @[79] = new OpCode('iastore', 'Store into int array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      
      array = thread.RDA.heap[arrayref]
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[80] = new OpCode('lastore', 'Store into long array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      
      array = thread.RDA.heap[arrayref]
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[81] = new OpCode('fastore', 'Store into float array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      
      array = thread.RDA.heap[arrayref]
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[82] = new OpCode('dastore', 'Store double into array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      
      array = thread.RDA.heap[arrayref]
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[83] = new OpCode('aastore', 'Store reference into Array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      #TODO value must be compatable with the arraytype
      
      array = thread.RDA.heap[arrayref]
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[84] = new OpCode('bastore', 'Store into byte or boolean Array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      array = @fromHeap(arrayref)
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[85] = new OpCode('castore', 'Store into char array', (frame) -> 
      value = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      arrayref = frame.op_stack.pop()
      array = @fromHeap(arrayref, thread)
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[86] = new OpCode('sastore', 'Store into short array', (frame) -> 
      arrayref = frame.op_stack.pop()
      arrayindex = frame.op_stack.pop()
      value = frame.op_stack.pop()
      array = @fromHeap(arrayref)
      if array is null
        athrow('NullPointerException')
      if arrayindex > array.length
        athrow('ArrayIndexOutOfBoundsException')
      array[arrayindex] = value
    )
    @[87] = new OpCode('pop', 'Pops top stack word', (frame) -> 
      frame.op_stack.pop() 
      yes
    )
    @[88] = new OpCode('pop2', 'Pops top two operand stack words', (frame) -> 
      frame.op_stack.pop()
      frame.op_stack.pop()
      yes
    )
    @[89] = new OpCode('dup', 'Duplicate top operand stack word', (frame) -> 
      frame.op_stack.push(frame.op_stack.peek())
    )
    @[90] = new OpCode('dup_x1', 'Duplicate top op stack word and put two down', (frame) -> 
      dupword = frame.op_stack.pop()
      word1 = frame.op_stack.pop()
      frame.op_stack.push(dupword)
      frame.op_stack.push(word1)
      frame.op_stack.push(dupword)
    )
    @[91] = new OpCode('dup_x2', 'Duplicate top op stack word and put three down', (frame) -> 
      dupword = frame.op_stack.pop()
      word2 = frame.op_stack.pop()
      word3 = frame.op_stack.pop()
      frame.op_stack.push(dupword)
      frame.op_stack.push(word3)
      frame.op_stack.push(word2)
      frame.op_stack.push(dupword)
      
    )
    @[92] = new OpCode('dup2', 'Duplicate top op stack words', (frame) -> 
      word1 = frame.op_stack.pop()    
      word2 = frame.op_stack.pop()    
      frame.op_stack.push(word2)
      frame.op_stack.push(word1)
      frame.op_stack.push(word2)
      frame.op_stack.push(word1)
    )
    @[93] = new OpCode('dup2_x1', 'Duplicate top two op stack words and put three down', (frame) -> 
      word1 = frame.op_stack.pop()
      word2 = frame.op_stack.pop()
      word3 = frame.op_stack.pop() 
      frame.op_stack.push(word2)
      frame.op_stack.push(word1)
      frame.op_stack.push(word3)
      frame.op_stack.push(word2)
      frame.op_stack.push(word1)
    )
    @[94] = new OpCode('dup2_x2', 'Duplicate top two op stack words and put four down', (frame) -> 
      word1 = frame.op_stack.pop()
      word2 = frame.op_stack.pop()
      word3 = frame.op_stack.pop() 
      word4 = frame.op_stack.pop()
      frame.op_stack.push(word2)
      frame.op_stack.push(word1)
      frame.op_stack.push(word4)
      frame.op_stack.push(word3)
      frame.op_stack.push(word2)
      frame.op_stack.push(word1)
    )
    @[95] = new OpCode('swap', 'Swap top two operand stack words', (frame) -> 
      word1 = frame.op_stack.pop()
      word2 = frame.op_stack.pop()
      frame.op_stack.push(word1)
      frame.op_stack.push(word2)
    )
    @[96] = new OpCode('iadd', 'Pops two values from the stack, adds them and pushes the result.', (frame) -> 
      i1 = frame.op_stack.pop()
      i2 = frame.op_stack.pop()
      if isNaN(i1.value) or isNaN(i2.value)
        frame.op_stack.push(new CONSTANT_integer(Number.NaN))
        return true
      frame.op_stack.push(new CONSTANT_integer(i1 + i2)) 
    )
    @[97] = new OpCode('ladd', 'Add long', (frame) -> 
      long1a = frame.op_stack.pop().valueOf()  
      long1b = frame.op_stack.pop().valueOf()
      
      long2a = frame.op_stack.pop().valueOf()
      long2b = frame.op_stack.pop().valueOf()
      
      if isNaN(long1a.value) or isNaN(long2a.value)
        frame.op_stack.push(new CONSTANT_long(Number.NaN))
        frame.op_stack.push(new CONSTANT_long(Number.NaN))
        return true
      frame.op_stack.push(new CONSTANT_long(long1a + long2a)) 
      frame.op_stack.push(new CONSTANT_long(long1a + long2a)) 
    )
    @[98] = new OpCode('fadd', 'Add float', (frame) -> 
      float1 = frame.op_stack.pop().valueOf()  
      float2 = frame.op_stack.pop().valueOf()
      if isNaN(float1.value) or isNaN(float2.value)
        frame.op_stack.push(new CONSTANT_float(Number.NaN))
        return true
      result = float2.value + float1.value
      frame.op_stack.push(new CONSTANT_float(result))
    )
    @[99] = new OpCode('dadd', 'Add double', (frame) -> 
      da1 = frame.op_stack.pop().valueOf()
      da2 = frame.op_stack.pop().valueOf()
      db1 = frame.op_stack.pop().valueOf()
      db2 = frame.op_stack.pop().valueOf()
      if isNaN(float1.value) or isNaN(float2.value)
        frame.op_stack.push(new CONSTANT_double(Number.NaN))
        frame.op_stack.push(new CONSTANT_double(Number.NaN))
        return true
      result = da1 + db1
      frame.op_stack.push(new CONSTANT_double(result))
      frame.op_stack.push(new CONSTANT_double(result))
    )
    @[100] = new OpCode('isub', 'Subtract int', (frame) -> 
      i2 = frame.op_stack.pop().valueOf()  
      i1 = frame.op_stack.pop().valueOf()
      result = i1 - i2
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[101] = new OpCode('lsub', 'Subtract long', (frame) -> 
      ia1 = frame.op_stack.pop().valueOf()  
      ia2 = frame.op_stack.pop().valueOf()
      ib1 = frame.op_stack.pop().valueOf()  
      ib2 = frame.op_stack.pop().valueOf()
      result = ib1 - ia1
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[102] = new OpCode('fsub', 'Subtract float', (frame) -> 
      f2 = frame.op_stack.pop().valueOf()  
      f1 = frame.op_stack.pop().valueOf()
      result = f1 - f2
      frame.op_stack.push(new CONSTANT_float(result))
    )
    @[103] = new OpCode('dsub', 'Subtract double', (frame) -> 
      d = frame.op_stack.pop().valueOf()
      d1 = frame.op_stack.pop().valueOf()
      d2 = frame.op_stack.pop().valueOf()
      d3 = frame.op_stack.pop().valueOf()
      result = d - d2
      frame.op_stack.push(new CONSTANT_double(result))
      frame.op_stack.push(new CONSTANT_double(result))
    )
    @[104] = new OpCode('imul', 'Multiply int', (frame) -> 
      f2 = frame.op_stack.pop().valueOf()  
      f1 = frame.op_stack.pop().valueOf()
      result = f1 * f2
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[105] = new OpCode('lmul', 'Multiple long', (frame) -> 
      la1 = frame.op_stack.pop().valueOf()  
      la2 = frame.op_stack.pop().valueOf()
      lb1 = frame.op_stack.pop().valueOf()  
      lb2 = frame.op_stack.pop().valueOf()
      if isNan(value1) or isNaN(value2)
        frame.op_stack.push(new CONSTANT_long(Number.NaN))  
        frame.op_stack.push(new CONSTANT_long(Number.NaN))  
      result = lb1 * la1
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[106] = new OpCode('fmul', 'Multiply float', (frame) -> 
      value2 = frame.op_stack.pop().valueOf()
      value1 = frame.op_stack.pop().valueOf()
      result = value1 * value2
      if isNaN(value1) or isNaN(value2)
        frame.op_stack.push(new CONSTANT_float(Number.NaN))  
      frame.op_stack.push(new CONSTANT_float(result))
    )
    @[107] = new OpCode('dmul', 'Multiply double', (frame) -> 
      d = frame.op_stack.pop().valueOf()
      d1 = frame.op_stack.pop().valueOf()
      d2 = frame.op_stack.pop().valueOf()
      d3 = frame.op_stack.pop().valueOf()
      result = d * d2
      frame.op_stack.push(new CONSTANT_double(result))
      frame.op_stack.push(new CONSTANT_double(result))
    )
    @[108] = new OpCode('idiv', 'Divide int', (frame) -> 
      value2 = frame.op_stack.pop().valueOf()
      value1 = frame.op_stack.pop().valueOf()
      if isNaN(value1) or isNaN(value2)
        frame.op_stack.push(new CONSTANT_integer(Integer.NaN))
      if value2 is 0
        athrow('ArithmeticException')
      result = value1 / value2
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[109] = new OpCode('ldiv', 'Divide long', (frame) -> 
      l2 = frame.op_stack.pop()
      l2a = frame.op_stack.pop()
      l1 = frame.op_stack.pop()
      l1a = frame.op_stack.pop()
      if isNaN(l1) or isNaN(l2)
        frame.op_stack.push(new CONSTANT_long(Integer.NaN))
        frame.op_stack.push(new CONSTANT_long(Integer.NaN))
      if l2 is 0
        athrow('ArithmeticException')
      result = l1 / l2
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[110] = new OpCode('fdiv', 'Divide float', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      if isNaN(value1) or isNaN(value2)
        frame.op_stack.push(new CONSTANT_float(Integer.NaN))
      if value2 is 0
        athrow('ArithmeticException')
      result = value1 / value2
      frame.op_stack.push(new CONSTANT_float(result))
    ) 
    @[111] = new OpCode('ddiv', 'Divide Double', (frame) -> 
      d2 = frame.op_stack.pop()
      d2a = frame.op_stack.pop()
      d1 = frame.op_stack.pop()
      d1a = frame.op_stack.pop()
      if isNaN(value1) or isNaN(value2)
        frame.op_stack.push(new CONSTANT_double(Integer.NaN))
        frame.op_stack.push(new CONSTANT_double(Integer.NaN))
      if d2 is 0
        athrow('ArithmeticException')
      result = d1 / d2
      frame.op_stack.push(new CONSTANT_double(result))
      frame.op_stack.push(new CONSTANT_double(result))
      # TODO check result abides by IEEE arithmetic  
    )
    @[112] = new OpCode('irem', 'Remainder int', (frame) -> 
      i2 = frame.op_stack.pop().valueOf()
      i1 = frame.op_stack.pop().valueOf()
      if i2 is 0
        athrow('ArithmeticException')
      result = i1 - (i1 / i2) * i2
      frame.op_stack.push(new CONSTANT_Int(result))
    )
    @[113] = new OpCode('lrem', 'Remainder long', (frame) -> 
      l2 = frame.op_stack.pop().valueOf()
      l1 = frame.op_stack.pop().valueOf()
      if l2 is 0
        athrow('ArithmeticException')
      result = l1 - (l1 / l2) * l2  
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[114] = new OpCode('frem', 'Remainder float', (frame) -> 
      console.log('frem not implemented')
    )
    @[115] = new OpCode('drem', 'Remainder double', (frame) -> 
      console.log('drem not implemented')
    )
    @[116] = new OpCode('ineg', 'Negate int', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      result = (~value) + 1
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[117] = new OpCode('lneg', 'Negate long', (frame) -> 
      la = frame.op_stack.pop().valueOf()
      lb = frame.op_stack.pop().valueOf()
      result = (~la) + 1
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[118] = new OpCode('fneg', 'Negate float', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      result = new CONSTANT_double(~(value.value) + 1)
      frame.op_stack.push(result)
    )
    @[119] = new OpCode('dneg', 'Negate double', (frame) -> 
      d1 = frame.op_stack.pop().valueOf()
      d2 = frame.op_stack.pop().valueOf()
      result = new CONSTANT_double(~(d1.value) + 1)
      frame.op_stack.push(result)
      frame.op_stack.push(result)
    )
    @[120] = new OpCode('ishl', 'Arithmetic shift left int', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      s = value2 & 0x1f
      result = value1 << s
      frame.op_stack.push(new CONSTANT_Intger(result))
    )
    @[121] = new OpCode('lshl', 'Arithmetic shift left long', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      s = value2 & 0x3f
      result = value1 << s
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[122] = new OpCode('ishr', 'Arithmetic shift right int', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      s = value2 & 0x1f
      result = value1 >> s
      frame.op_stack.push(new CONSTANT_Intger(result))
    )
    @[123] = new OpCode('lshr', 'Arithmetic shift right long', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      s = value2 & 0x3f
      result = value1 >> s
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[124] = new OpCode('iushr', 'Logical shift right int', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      s = value2 & 0x1f
      if value1 > 0
        result = value1 >> s
      else 
        result = (value1 >> s) + (2 << ~s)
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[125] = new OpCode('lushr', 'Logical shift right long', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      s = value2 & 0x1f
      if value1 > 0
        result = value1 >> s
      else 
        result = (value1 >> s) + (2 << ~s)
        
      frame.op_stack.push(new CONSTANT_long(result))     
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[126] = new OpCode('iand', 'Boolean AND int', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      result = value1 & value2
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[127] = new OpCode('land', 'Boolean ', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      result = value1 & value2
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[128] = new OpCode('ior', '', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      result = value1 | value2
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[129] = new OpCode('lor', 'Boolean OR long', (frame) -> 
      l1 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      l2 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop().valueOf()
      result = l1 | l2  
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[130] = new OpCode('ixor', 'Boolean XOR int', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      value2 = frame.op_stack.pop().valueOf()
      result = value1 ^ value2
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[131] = new OpCode('lxor', 'Boolean XOR long', (frame) -> 
      value1 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop()
      value2 = frame.op_stack.pop().valueOf()
      frame.op_stack.pop()
      result = value1 ^ value2
      frame.op_stack.push(new CONSTANT_long(result))
      frame.op_stack.push(new CONSTANT_long(result))
    )
    @[132] = new OpCode('iinc', 'Increment local variable by constant', (frame) -> 
      index = getIndexByte(1, frame, thread)
      consta = getIndexByte(2, frame, thread)
      result = index + consta
      frame.op_stack.push(new CONSTANT_integer(result))
    )
    @[133] = new OpCode('i2l', 'Convert int to long', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      long = new CONSTANT_long(value)
      frame.op_stack.push(long)
      frame.op_stack.push(long)
    )
    @[134] = new OpCode('i2f', 'Convert int to float', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      float = new CONSTANT_float(value)
      frame.op_stack.push(float)
    )
    @[135] = new OpCode('i2d', 'Convert int to double', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      double = new CONSTANT_double(value)
      frame.op_stack.push(double)
    )
    @[136] = new OpCode('l2i', 'Convert long to int', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      int = new CONSTANT_integer(value.toFixed())
      frame.op_stack.push(int)
    )
    @[137] = new OpCode('l2f', 'Convert long to float', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      float = new CONSTANT_float(value)
      frame.op_stack.push(float)
    )
    @[138] = new OpCode('l2d', 'Convert long to double', (frame) -> 
      value = frame.op_stack.pop().valueOf()
      double = new CONSTANT_double(value)
      frame.op_stack.push(double)
    )
    @[139] = new OpCode('f2i', 'Convert float to int', (frame) -> 
      float = frame.op_stack.pop().valueOf()
      int = new CONSTANT_integer(float.toFixed())
      frame.op_stack.push(int)
    )
    @[140] = new OpCode('f2l', 'Convert Float to long', (frame) -> 
      float = frame.op_stack.pop().valueOf()
      long = new CONSTANT_long(float.toFixed())
      frame.op_stack.push(long)
      frame.op_stack.push(long)
    )
    @[141] = new OpCode('f2d', 'Convert float to double', (frame) -> 
      float = frame.op_stack.pop().valueOf()
      double = new CONSTANT_double(float.value)
      frame.op_stack.push(double)
      frame.op_stack.push(double)
    )
    @[142] = new OpCode('d2i', 'Convert double to int', (frame) -> 
      double = frame.op_stack.pop().valueOf()
      int = new CONSTANT_integer(float.toFixed())
      frame.op_stack.push(int)
    )
    @[143] = new OpCode('d2l', 'Convert double to long', (frame) -> 
      double = frame.op_stack.pop().valueOf()
      frame.op_stack.pop()
      long = new CONSTANT_float(long.toFixed())
      frame.op_stack.push(long)
      frame.op_stack.push(long)
    )
    @[144] = new OpCode('d2f', 'Convert double to float', (frame) -> 
      double = frame.op_stack.pop().valueOf()
      frame.op_stack.pop()
      float = new CONSTANT_float(double)
      frame.op_stack.push(float)
    )
    @[145] = new OpCode('i2b', 'Convert int to byte', (frame) -> 
      int = frame.op_stack.pop().valueOf()
      byte = new CONSTANT_byte(int)
      frame.op_stack.push(byte)
    )
    @[146] = new OpCode('i2c', 'Convert int to char', (frame) -> 
      int = frame.op_stack.pop().valueOf();
      char = new CONSTANT_char(int)
      frame.op_stack.push(char)
    )
    @[147] = new OpCode('i2s', 'Convert int to short', (frame) -> 
      int = frame.op_stack.pop().valueOf()
      short = new CONSTANT_short(int)
      frame.op_stack.push(short)
    )
    @[148] = new OpCode('lcmp', 'Compare long', (frame) -> 
      value2a = frame.op_stack.pop().valueOf()
      value2b = frame.op_stack.pop().valueOf()
      value1a = frame.op_stack.pop().valueOf()
      value1b = frame.op_stack.pop().valueOf()
      if value1a > value2a
        frame.op_stack.push(1)
      else if value1a == value2a
        frame.op_stack.push(0)
      else if value1a < value2a 
        frame.op_stack.push(-1)
    )
    @[149] = new OpCode('fcmpl', 'Compare float, push -1 for NaN', (frame) -> 
      value2 = frame.op_stack.pop().valueOf()
      value1 = frame.op_stack.pop().valueOf()          
      if isNaN(value1) || isNaN(value2)
        frame.op_stack.push(-1) 
      else if value1 > value2
        frame.op_stack.push(1)
      else if value1 == value2
        frame.op_stack.push(0)
      else if value1 < value2
        frame.op_stack.push(-1)
    )
    @[150] = new OpCode('fcmpg', 'Compare float, push 1 for NaN', (frame) -> 
      value2 = frame.op_stack.pop().valueOf()
      value1 = frame.op_stack.pop().valueOf()          
      if isNaN(value1) || isNaN(value2)
        frame.op_stack.push(1) 
      else if value1 > value2
        frame.op_stack.push(1)
      else if value1 == value2
        frame.op_stack.push(0)
      else if value1 < value2
        frame.op_stack.push(-1)  
    )
    @[151] = new OpCode('dcmpl', 'Compare double, push -1 for NaN', (frame) -> 
      value2a = frame.op_stack.pop().valueOf()
      value2b = frame.op_stack.pop().valueOf()
      value1a = frame.op_stack.pop().valueOf()
      value1b = frame.op_stack.pop().valueOf()
      if isNaN(value1a) || isNaN(value2a)
        frame.op_stack.push(-1) 
      else if value1a > value2a
        frame.op_stack.push(1)
      else if value1a == value2a
        frame.op_stack.push(0)
      else if value1a < value2a
        frame.op_stack.push(-1)
    )
    @[152] = new OpCode('dcmpg', 'Compare double, push 1 for NaN', (frame) -> 
      value2a = frame.op_stack.pop().valueOf()
      value2b = frame.op_stack.pop().valueOf()
      value1a = frame.op_stack.pop().valueOf()
      value1b = frame.op_stack.pop().valueOf()
      if isNaN(value1a) || isNaN(value2a)
        frame.op_stack.push(1) 
      else if value1a > value2a
        frame.op_stack.push(1)
      else if value1a == value2a
        frame.op_stack.push(0)
      else if value1a < value2a
        frame.op_stack.push(-1)
    )
    @[153] = new OpCode('ifeq', 'Branch if value is 0', (frame) -> 
      branch = @constructIndex(frame, thread);
      if frame.op_stack.pop() is 0 
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[154] = new OpCode('ifne', 'Branch if value isnt 0', (frame) -> 
      branch = @constructIndex(frame, thread);
      if frame.op_stack.pop() isnt 0
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[155] = new OpCode('iflt', 'Branch if value < 0', (frame) -> 
      branch = @constructIndex(frame, thread);
      if frame.op_stack.pop() < 0
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[156] = new OpCode('ifge', 'Branch if value >= 0', (frame) -> 
      branch = @constructIndex(frame, thread)
      if frame.op_stack.pop() >= 0
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[157] = new OpCode('ifgt', 'Branch if value > 0', (frame) -> 
      branch = @constructIndex(frame, thread);  
      if frame.op_stack.pop() > 0 
        thread.pc -= 3       
        thread.pc += branch
      yes
    )
    @[158] = new OpCode('ifle', 'Branch if value <= 0', (frame) -> 
      branch = @constructIndex(frame, thread);
      if frame.op_stack.pop() <= 0
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[159] = new OpCode('if_icmpeq', 'Branch if int1 == int2', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread);
      if value1 is value2
        thread.pc -= 3       
        thread.pc += branch
      yes
    )
    @[160] = new OpCode('if_icmpne', 'Branch if int1 != int2', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread);
      if value1 isnt value2
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[161] = new OpCode('if_icmplt', 'Branch if int1 < int2', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread)
      if value1 < value2
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[162] = new OpCode('if_icmpge', 'Branch if int1 >= int2', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread)
      if value1 >= value2
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[163] = new OpCode('if_icmpgt', 'Branch if int1 > int2', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread);
      if value1 > value2
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[164] = new OpCode('if_icmple', 'Branch if int1 <= int2', (frame) -> 
      value2 = frame.op_stack.pop()
      value1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread);
      if value1 <= value2
        thread.pc -= 3  
        thread.pc += branch
      yes
    )
    @[165] = new OpCode('if_acmpeq', 'Branch if ref1 === ref2', (frame) -> 
      ref2 = frame.op_stack.pop()
      ref1 = frame.op_stack.pop()
      if ref1 is ref2
        branch = @constructIndex(frame, thread);
        thread.pc -= 3
        thread.pc += branch
      yes
    )
    @[166] = new OpCode('if_acmpne', 'Branch if ref1 !== ref2', (frame) -> 
      ref2 = frame.op_stack.pop()
      ref1 = frame.op_stack.pop()
      branch = @constructIndex(frame, thread);
      if ref1 isnt ref2
        thread.pc -= 3        
        thread.pc += branch
      yes
    )
    @[167] = new OpCode('goto', 'Branch always', (frame) -> 
      offset = @constructIndex(frame, thread)
      thread.pc -= 3
      thread.pc += offset
    )
    @[168] = new OpCode('jsr', 'Jump to subroutine', (frame) -> 
      # push the next operation for return
      frame.op_stack.push(thread.pc)
      # get the branch offset
      offset = @constructIndex(frame, thread)
      thread.pc -= 3
      thread.pc += offset
    )
    @[169] = new OpCode('ret', 'Return from subroutine', (frame) -> 
      index = @getByteIndex(1)
      thread.pc = frame.locals[index]
    )
    @[170] = new OpCode('tableswitch', '', (frame) -> 
      alert(@mnemonic)
    yes )
    @[171] = new OpCode('lookupswitch', '', (frame) -> 
      alert(@mnemonic)
    yes )
    @[172] = new OpCode('ireturn', 'Return an int', (frame) -> 
      # get the int to return
      ireturn = frame.op_stack.pop()
      # pop the current method to discard
      if(thread.current_frame instanceof NativeFrame)
        thread.native_stack.pop()
        if(thread.native_stack.peek()?)
          thread.current_frame = thread.native_stack.peek()  
        else
          thread.current_frame = thread.jvm_stack.peek()
      else    
        # pop the current method to discard
        thread.jvm_stack.pop()
        
      # get the invoking method and push the int to its stack
      invoker = thread.jvm_stack.peek()
      invoker.op_stack.push(ireturn)
      # make invoker current and set pc to where invoker was left off
      thread.current_frame = invoker
      thread.current_class = invoker.cls
      thread.pc = invoker.pc    
    )
    @[173] = new OpCode('lreturn', 'Return long from method', (frame) -> 
      
      # get long
      retlong = frame.op_stack.pop()
      frame.op_stack.pop()
      # pop the current method to discard
      if(thread.current_frame instanceof NativeFrame)
        thread.native_stack.pop()
        if(thread.native_stack.peek()?)
          thread.current_frame = thread.native_stack.peek()  
        else
          thread.current_frame = thread.jvm_stack.peek()
      else    
        # pop the current method to discard
        thread.jvm_stack.pop()
        
      # push the ref to the stack of the invoking method.
      invoker = thread.jvm_stack.peek()
      invoker.op_stack.push(retlong)
      invoker.op_stack.push(retlong)
      # make invoker current and set pc to where invoker was left off
      thread.current_frame = invoker
      thread.current_class = invoker.cls
      thread.pc = invoker.pc
    )
    @[174] = new OpCode('freturn', 'Return float from method', (frame) -> 
      # get float
      retfloat = frame.op_stack.pop()
      # pop the current method to discard
      if(thread.current_frame instanceof NativeFrame)
        thread.native_stack.pop()
        if(thread.native_stack.peek()?)
          thread.current_frame = thread.native_stack.peek()  
        else
          thread.current_frame = thread.jvm_stack.peek()
      else    
        # pop the current method to discard
        thread.jvm_stack.pop()
        
      # push the ref to the stack of the invoking method.
      invoker = thread.jvm_stack.peek()
      invoker.op_stack.push(retfloat)
      # make invoker current and set pc to where invoker was left off
      thread.current_frame = invoker
      thread.current_class = invoker.cls
      thread.pc = invoker.pc
    )
    @[175] = new OpCode('dreturn', 'Return double from method', (frame) -> 
      
      # get double
      retdouble = frame.op_stack.pop()
      # pop the current method to discard
      if(thread.current_frame instanceof NativeFrame)
        thread.native_stack.pop()
        if(thread.native_stack.peek()?)
          thread.current_frame = thread.native_stack.peek()  
        else
          thread.current_frame = thread.jvm_stack.peek()
      else    
        # pop the current method to discard
        thread.jvm_stack.pop()
        
      # push the ref to the stack of the invoking method.
      invoker = thread.jvm_stack.peek()
      invoker.op_stack.push(retdouble)
      # make invoker current and set pc to where invoker was left off
      thread.current_frame = invoker
      thread.current_class = invoker.cls
      thread.pc = invoker.pc
    )
    @[176] = new OpCode('areturn', 'Return reference', (frame) -> 
      
      # get the ref to return
      returnref = frame.op_stack.pop()
      if(thread.current_frame instanceof NativeFrame)
        thread.native_stack.pop()
        if(thread.native_stack.peek()?)
          thread.current_frame = thread.native_stack.peek()  
        else
          thread.current_frame = thread.jvm_stack.peek()
      else    
        # pop the current method to discard
        thread.jvm_stack.pop()
        
      # push the ref to the stack of the invoking method.
      invoker = thread.jvm_stack.peek()
      invoker.op_stack.push(returnref)
      # make invoker current and set pc to where invoker was left off
      thread.current_frame = invoker
      thread.current_class = invoker.cls
      thread.pc = invoker.pc
      
    )
    @[177] = new OpCode('return', 'Return void from method', (frame) -> 
      
      # get the appropriate return frame
      if(thread.current_frame instanceof NativeFrame)
        thread.native_stack.pop()
        if(thread.native_stack.peek()?)
          thread.current_frame = thread.native_stack.peek()  
        else
          thread.current_frame = thread.jvm_stack.peek()
      else
        thread.jvm_stack.pop()

      invoker = thread.jvm_stack.peek()
      thread.current_frame = invoker
      
      if thread.current_frame?
        thread.pc = thread.current_frame.pc
        thread.current_class = invoker.cls
      yes
      
    )
    @[178] = new OpCode('getstatic', 'Fetch static field from class', (frame) -> 
      ref = @constructIndex(frame, thread)
      class_field_ref = thread.current_class.constant_pool[ref]
      
      # get the class the owns the static field 
      class_ref = thread.current_class.constant_pool[class_field_ref.class_index]
      
      if(cls = thread.resolveClass(class_ref)) == null
        return false
          
      field_name_type = thread.current_class.constant_pool[class_field_ref.name_and_type_index]
      field_name = thread.current_class.constant_pool[field_name_type.name_index]
      frame.op_stack.push(cls.fields[field_name])
      
      yes
    # not yet implemented
    yes )
    @[179] = new OpCode('putstatic', 'Set static field in class', (frame) -> 
      ref = @constructIndex(frame, thread)
      class_field_ref = thread.current_class.constant_pool[ref]

      # get the class the owns the static field       
      if(cls = thread.resolveClass(class_field_ref.class_index)) == null
        return false

      field_ref = thread.current_class.constant_pool[class_field_ref.name_and_type_index]
      field_name = thread.current_class.constant_pool[field_ref.name_index]
      field_type = thread.current_class.constant_pool[field_ref.descriptor_index]
      #cls = thread.current_class.constant_pool[class_ref]
      
      
      value = frame.op_stack.pop()
      # set field value
      cls.fields[field_name] = value
    )
    @[180] = new OpCode('getfield', 'Get a field from an object', (frame) -> 
      objectref = frame.op_stack.pop()
      index = @constructIndex(frame, thread)
      fieldref = @fromClass(index, thread)
      if objectref is null
        athrow('NullPointerException')
      nameandtype = @fromClass(fieldref.name_and_type_index, thread)
      fieldname = @fromClass(nameandtype.name_index, thread)
      descriptor = @fromClass(nameandtype.descriptor_index, thread)
      field = @fromHeap(objectref.pointer, thread).fields[fieldname]
      frame.op_stack.push(field)
      yes
      # TODO check method stuff (protected etc)
    )
    @[181] = new OpCode('putfield', 'Set a field in an object', (frame) -> 
      value =   frame.op_stack.pop()
      objectref = frame.op_stack.pop() 
      index = @constructIndex(frame, thread)
      fieldref = @fromClass(index, thread)
      if objectref is null
        athrow('NullPointerException')
      nameandtype = @fromClass(fieldref.name_and_type_index, thread)
      fieldname = @fromClass(nameandtype.name_index, thread)
      descriptor = @fromClass(nameandtype.descriptor_index, thread)
      object = @fromHeap(objectref.pointer, thread)
      object.fields[fieldname] = value  
      yes
      # TODO check method stuff (protected etc)
    )
    @[182] = new OpCode('invokevirtual', 'Invoke instance method; dispatch based on class', (frame) -> 
      index = @constructIndex(frame, thread)
      methodref = @fromClass(index, thread)
      
      methodnameandtype = @fromClass(methodref.name_and_type_index, thread)
      
      if(cls = thread.resolveClass(methodref.class_index)) == null
        return false
        
          
      method_name = @fromClass(methodnameandtype.name_index, thread)
      type = @fromClass(methodnameandtype.descriptor_index, thread)
      method = thread.resolveMethod(method_name, cls, type)
      
      if method.access_flags & thread.RDA.JVM.JVM_RECOGNIZED_METHOD_MODIFIERS.JVM_ACC_STATIC
        athrow('IncompatibleClassChangeError')
      if method.access_flags & thread.RDA.JVM.JVM_RECOGNIZED_METHOD_MODIFIERS.JVM_ACC_ABSTRACT
        athrow('AbstractMethodError')
              
      newframe = thread.createFrame(method, cls)
      thread.current_class = cls
      frame.pc += 2
      thread.pc = -1
      
      arg_num = method.nargs
      while arg_num > 0
        newframe.locals[arg_num--] = frame.op_stack.pop()
      # push objectref to represent 'this' in the object
      newframe.locals[0] = frame.op_stack.pop()
      if newframe.locals[0] == null
        @athrow('NullPointerException')
      yes 
    )
    @[183] = new OpCode('invokespecial', 'Invoke instance method', (frame) -> 
      # get method ref from operands
      methodref = @fromClass(@constructIndex(frame, thread), thread)
      
      if not(methodref instanceof CONSTANT_Methodref_info)
        throw 'Opcode 183 error.'
      
      if(cls = thread.resolveClass(methodref.class_index)) == null
        return false
              
      method_name_and_type = @fromClass(methodref.name_and_type_index, thread)
      method_name = @fromClass(method_name_and_type.name_index, thread)
      type = @fromClass(method_name_and_type.descriptor_index, thread)
      method = thread.resolveMethod(method_name, cls, type)
      
      #if thread.current_class == cls && cls.access_flags & thread.RDA.JVM.JVM_RECOGNIZED_CLASS_MODIFIERS.JVM_ACC_SUPER 
      #return true
        
      # set frame and class
      newframe = thread.createFrame(method, cls)
      thread.current_class = cls
      
      # set frame pc to skip operands, and machine pc to nil for new method
      frame.pc += 2
      thread.pc = -1
      # pop the args off the current op_stack into the local vars of the new frame
      arg_num = method.nargs
      while arg_num > 0
        newframe.locals[arg_num--] = frame.op_stack.pop()
      # put objectref (this) in new method local 0
      newframe.locals[0] = frame.op_stack.pop()
      yes
    )
    @[184] = new OpCode('invokestatic', 'Invoke a class (static) method', (frame) -> 
      # cp ref
      methodref = @fromClass(@constructIndex(frame, thread), thread)
            
      if(cls = thread.resolveClass(methodref.class_index)) == null
        return false
         
      method_name_and_type = @fromClass(methodref.name_and_type_index, thread)
      method_name = @fromClass(method_name_and_type.name_index, thread)   
      type = @fromClass(method_name_and_type.descriptor_index, thread)
      method = thread.resolveMethod(method_name, cls, type)
      
      thread.current_class = cls
      # set frame pc to skip operands, and machine pc to nil for new method
      frame.pc += 2
      thread.pc = -1
      
      # create new frame for the static method
      newframe = thread.createFrame(method, thread.current_class)
      # pop the args off the current op_stack into the local vars of the new frame
      arg_num = method.nargs
      # store args in locals; arg1 = locals[0] etc
      while arg_num > 0
        newframe.locals[--arg_num] = frame.op_stack.pop()
      # put objectref (this) in new method local 0
      yes
       
    )
    @[185] = new OpCode('invokeinterface', '', (frame) -> 
      alert(@mnemonic)
    yes )
    @[186] = new OpCode('xxxunusedxxx', '', (frame) -> 
      alert(@mnemonic)
    yes )
    @[187] = new OpCode('new', 'Create new Object', (frame) -> 
      index = @constructIndex(frame, thread)
      clsref = thread.current_class.constant_pool[index]
      # TODO check if interface, array or abstract and throw instantiationException
      
      if(cls = thread.resolveClass(clsref)) == null
        return false
        
      objectref = thread.RDA.heap.allocate(new JVM_Object(cls))
      frame.op_stack.push(objectref)
      
    )
    @[188] = new OpCode('newarray', 'Create a new array', (frame) -> 
      atype = @getIndexByte(1, frame, thread)
      count = frame.op_stack.pop()
      if count < 0
        athrow 'NegativeArraySizeException'  
      switch atype
        when 4 then t = 'Z'
        when 5 then t = 'C'
        when 6 then t = 'F'
        when 7 then t = 'D'
        when 8 then t = 'B'
        when 9 then t = 'S'
        when 10 then t = 'I'
        when 11 then t = 'J'
      arrayref = thread.RDA.heap.allocate(new CONSTANT_Array(count, t))
      frame.op_stack.push(arrayref)
      yes
    )
    @[189] = new OpCode('anewarray', 'Create new array of reference', (frame) -> 
      
      cpindex = @constructIndex(frame, thread)

      if(cls = thread.resolveClass(cpindex)) == null
        return false
        
      count = frame.op_stack.pop()
      if count < 0
        athrow('NegativeArraySizeException')

      arrayref = thread.RDA.heap.allocate(new CONSTANT_Array(count, 'L' + cls.real_name))
      frame.op_stack.push(arrayref)
    )
    @[190] = new OpCode('arraylength', 'Get length of array', (frame) -> 
      arrayref = frame.op_stack.pop()
      if arrayref == null 
        # TODO throw NullPointerException
        return false
      array = thread.RDA.heap[arrayref.pointer]
      len = array.length
      frame.op_stack.push(len)    
    )
    @[191] = new OpCode('athrow', 'Throw exception or error', (frame) -> 
      objectref = frame.op_stack.pop()
      if ojectref == null
        athrow("NullPointerException")
        return false
      # while a catch clause is not found
      caught = false
      while not caught
        thread.current_frame.att
        thread.jvm_stack.pop()
        thread.current_frame = thread.jvm_stack.peek()
      #TODO...  something here... 
      
      
    )
    @[192] = new OpCode('checkcast', 'Check if object is of a given type', (frame) -> 
      # do not alter the op stack
      objectref = frame.op_stack.peek()
      clsindex = @constructIndex(frame, thread)
      # s comes from heap, T from the class constant pool
      S = @fromHeap(objectref, thread)
      
      if(T = thread.resolveClass(clsindex)) == null
        return false
                
      if objectref == null
        return true
        
      # if T is class type then S must be the same class, or a subclass of T
      if T.real_name is S.cls.real_name
        frame.op_stack.push(objectref)
        return true
      athrow('ClassCastException')
          
      # TODO check shit here pg 175
             
    )
    @[193] = new OpCode('instanceof', 'Check if object is an instance of class', (frame) -> 
      objectref = frame.op_stack.pop()
      clsindex = @fromClass(@constructIndex(frame, thread), thread)
      
      if(cls = thread.resolveClass(clsindex)) == null
        return false
       
      object = @fromHeap(objectref, thread)
      # make a new object of type cls to compare with object
      
      if cls.real_name is object.cls.real_name
        frame.op_stack.push(1)
      else 
        frame.op_stack.push(0)
      
      yes  
    )
    @[194] = new OpCode('monitorenter', 'Enter monitor for object', (frame) -> 
      object = frame.op_stack.pop()
      if !object instanceof CONSTANT_Class
        object = @fromHeap(object, thread)
      # aquire monitor
      if !object.monitor.aquireLock(thread)
        # wait to be notified by objects monitor
        console.log("Two locks on one object!")
        return false
      yes
    )
    @[195] = new OpCode('monitorexit', '', (frame) -> 
      objectref = frame.op_stack.pop()
      object = @fromHeap(objectref, thread)
      # release monitor
      if !object.monitor.releaseLock(thread)
        athrow('IllegalMonitorStateException')
      yes 
    )
    @[196] = new OpCode('wide', '', (frame) -> 
      alert(@mnemonic)#  not yet implemented
    yes )
    @[197] = new OpCode('multianewarray', '', (frame) -> 
      alert(@mnemonic)# not yet implemented
    yes )
    @[198] = new OpCode('ifnull', 'Branch if null', (frame) -> 
      branch = @constructIndex(frame, thread)
      value = frame.op_stack.pop()
      if value is null
        thread.pc -= 3
        thread.pc += branch
      yes  
    )
    @[199] = new OpCode('ifnonnull', 'Branch if non-null', (frame) -> 
      branch = @constructIndex(frame, thread)
      value = frame.op_stack.pop()
      if value isnt null
        thread.pc -= 3
        thread.pc += branch
      yes      
    )
    @[200] = new OpCode('goto_w', '', (frame) -> 
      alert(@mnemonic)# not yet implemented
    yes )
    @[201] = new OpCode('jsr_w', '', (frame) -> 
      alert(@mnemonic)# not yet implemented
    yes )
    @[202] = new OpCode('breakpoint', '', (frame) -> 
      alert(@mnemonic)# not yet implemented
    yes )
    @[203] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[204] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[205] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[206] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[207] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[208] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[209] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[210] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[211] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[212] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[213] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[214] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[215] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[216] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[217] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[218] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[219] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[220] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[221] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[222] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[223] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[224] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[225] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[226] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[227] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[228] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[229] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[230] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[231] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[232] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[233] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[234] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[235] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[236] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[237] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[238] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[239] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[240] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[241] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[242] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[243] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[244] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[245] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[246] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[247] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[248] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[249] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[250] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[251] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[252] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[253] = new OpCode('', '', (frame) -> 
    # not yet implemented
    yes )
    @[254] = new OpCode('impdep1', '', (frame) -> 
    # not yet implemented
    yes )
    @[255] = new OpCode('impdep2', '', (frame) -> 
    # not yet implemented
    yes )
        
  
  
    
class OpCode
  constructor : (@mnemonic, @description, @do) ->
    this
    
  
    
  getIndexByte : (index, frame, thread) ->
    index = frame.method_stack[(thread.pc)+index]
    thread.pc++
    return index
    
  
  constructIndex : (frame, thread) ->  
    indexbyte1 = @getIndexByte(1, frame, thread)
    indexbyte2 = @getIndexByte(1, frame, thread)
    return indexbyte1 << 8 | indexbyte2  
    
    
  fromHeap : (ref, thread) ->
    return thread.RDA.heap[ref]
      
  fromClass : (index, thread) ->
    item = thread.current_class.constant_pool[index]
    if item instanceof CONSTANT_Stringref
      item = thread.RDA.JVM.JVM_ResolveStringLiteral(thread.current_class.constant_pool[item.string_index])
      thread.current_class.constant_pool[index] = item
    return item  
      
  
  athrow : (exception) ->
    throw exception