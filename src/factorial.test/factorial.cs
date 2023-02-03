using System;
using Xunit;
using Numerics = math.numerics;

namespace math.numerics.test.specialfunctions
{
    public class Factorial
    {
        [Fact]
        public void Throws_If_Argument_Is_Negative() {
            Assert.Throws<ArgumentOutOfRangeException>(() => Numerics.SpecialFunctions.Factorial(-1));
        }

        [Fact]
        public void Factorial_Of_Zero_Is_One()
        {
            Assert.Equal(1, Numerics.SpecialFunctions.Factorial(0));
        }

        [Fact]
        public void Factorial_Of_One_Is_One()
        {
            Assert.Equal(1, Numerics.SpecialFunctions.Factorial(1));
        }

        [Fact]
        public void Factorial_Of_Five_Is_120()
        {
            Assert.Equal(120, Numerics.SpecialFunctions.Factorial(5));
        }

        [Fact]
        public void Factorial_Of_18_Is_Exact()
        {
            Assert.Equal(6402373705728000, Numerics.SpecialFunctions.Factorial(18));
        }

        [Fact]
        public void Factorial_Of_170_Is_Computable()
        {
            Assert.Equal(7.257415615307994E+306, Numerics.SpecialFunctions.Factorial(170));
        }

        [Fact]
        public void Factorial_Larger_170_Returns_Infinity() {
            Assert.Equal(double.PositiveInfinity, Numerics.SpecialFunctions.Factorial(171));
        }
    }
}
