class DVector{
  public double x;
  public double y;
  public double z;

  double[] array;


  /**
   * Constructor for an empty vector: x, y, and z are set to 0.
   */
  public DVector() {
  }


  /**
   * Constructor for a 3D vector.
   *
   * @param  x the x coordinate.
   * @param  y the y coordinate.
   * @param  z the z coordinate.
   */
  public DVector(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }


  /**
   * Constructor for a 2D vector: z coordinate is set to 0.
   */
  public DVector(double x, double y) {
    this.x = x;
    this.y = y;
  }



  /*
    return a PVector as a DVector
  */
  public PVector dToPVector(){
    PVector v2 = new PVector((float)this.x, (float)this.y, (float)this.z);
    return v2; 
  }


  public DVector set(double x, double y, double z) {
    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }


  /**
   * @param x the x component of the vector
   * @param y the y component of the vector
   */
  public DVector set(double x, double y) {
    this.x = x;
    this.y = y;
    this.z = 0;
    return this;
  }

  /**
   * @param v any variable of type DVector
   */
  public DVector set(DVector v) {
    x = v.x;
    y = v.y;
    z = v.z;
    return this;
  }


  /**
   * Set the x, y (and maybe z) coordinates using a double[] array as the source.
   * @param source array to copy from
   */
  public DVector set(double[] source) {
    if (source.length >= 2) {
      x = source[0];
      y = source[1];
    }
    if (source.length >= 3) {
      z = source[2];
    } else {
      z = 0;
    }
    return this;
  }


  public DVector copy() {
    return new DVector(x, y, z);
  }

  public double[] get(double[] target) {
    if (target == null) {
      return new double[] { x, y, z };
    }
    if (target.length >= 2) {
      target[0] = x;
      target[1] = y;
    }
    if (target.length >= 3) {
      target[2] = z;
    }
    return target;
  }


  
  public double mag() {
    return (double) Math.sqrt(x*x + y*y + z*z);
  }


  public double magSq() {
    return (x*x + y*y + z*z);
  }


  public DVector add(DVector v) {
    x += v.x;
    y += v.y;
    z += v.z;
    return this;
  }



  public DVector add(double x, double y) {
    this.x += x;
    this.y += y;
    return this;
  }


  public DVector add(double x, double y, double z) {
    this.x += x;
    this.y += y;
    this.z += z;
    return this;
  }


  public DVector add(DVector v1, DVector v2) {
    return add(v1, v2, null);
  }


  public DVector add(DVector v1, DVector v2, DVector target) {
    if (target == null) {
      target = new DVector(v1.x + v2.x,v1.y + v2.y, v1.z + v2.z);
    } else {
      target.set(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
    }
    return target;
  }


  public DVector sub(DVector v) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
    return this;
  }


  public DVector sub(double x, double y) {
    this.x -= x;
    this.y -= y;
    return this;
  }


  public DVector sub(double x, double y, double z) {
    this.x -= x;
    this.y -= y;
    this.z -= z;
    return this;
  }


  public DVector sub(DVector v1, DVector v2) {
    return sub(v1, v2, null);
  }


  public DVector sub(DVector v1, DVector v2, DVector target) {
    if (target == null) {
      target = new DVector(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
    } else {
      target.set(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
    }
    return target;
  }

  public DVector mult(double n) {
    x *= n;
    y *= n;
    z *= n;
    return this;
  }


  public DVector mult(DVector v, double n) {
    return mult(v, n, null);
  }


  public DVector mult(DVector v, double n, DVector target) {
    if (target == null) {
      target = new DVector(v.x*n, v.y*n, v.z*n);
    } else {
      target.set(v.x*n, v.y*n, v.z*n);
    }
    return target;
  }


  public DVector div(double n) {
    x /= n;
    y /= n;
    z /= n;
    return this;
  }


   public DVector div(DVector v, double n) {
    return div(v, n, null);
  }


   DVector div(DVector v, double n, DVector target) {
    if (target == null) {
      target = new DVector(v.x/n, v.y/n, v.z/n);
    } else {
      target.set(v.x/n, v.y/n, v.z/n);
    }
    return target;
  }


  public double dist(DVector v) {
    double dx = x - v.x;
    double dy = y - v.y;
    double dz = z - v.z;
    return (double) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }


  public double dist(DVector v1, DVector v2) {
    double dx = v1.x - v2.x;
    double dy = v1.y - v2.y;
    double dz = v1.z - v2.z;
    return (double) Math.sqrt(dx*dx + dy*dy + dz*dz);
  }


  /**
   * ( begin auto-generated from DVector_dot.xml )
   *
   * Calculates the dot product of two vectors.
   *
   * ( end auto-generated )
   *
   * @webref DVector:method
   * @usage web_application
   * @param v any variable of type DVector
   * @return the dot product
   * @brief Calculate the dot product of two vectors
   */
  public double dot(DVector v) {
    return x*v.x + y*v.y + z*v.z;
  }


  /**
   * @param x x component of the vector
   * @param y y component of the vector
   * @param z z component of the vector
   */
  public double dot(double x, double y, double z) {
    return this.x*x + this.y*y + this.z*z;
  }


  /**
   * @param v1 any variable of type DVector
   * @param v2 any variable of type DVector
   */
  public double dot(DVector v1, DVector v2) {
    return v1.x*v2.x + v1.y*v2.y + v1.z*v2.z;
  }


  public DVector cross(DVector v) {
    return cross(v, null);
  }


  public DVector cross(DVector v, DVector target) {
    double crossX = y * v.z - v.y * z;
    double crossY = z * v.x - v.z * x;
    double crossZ = x * v.y - v.x * y;

    if (target == null) {
      target = new DVector(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target;
  }


  public DVector cross(DVector v1, DVector v2, DVector target) {
    double crossX = v1.y * v2.z - v2.y * v1.z;
    double crossY = v1.z * v2.x - v2.z * v1.x;
    double crossZ = v1.x * v2.y - v2.x * v1.y;

    if (target == null) {
      target = new DVector(crossX, crossY, crossZ);
    } else {
      target.set(crossX, crossY, crossZ);
    }
    return target;
  }


  public DVector normalize() {
    double m = mag();
    if (m != 0 && m != 1) {
      div(m);
    }
    return this;
  }
  
  public DVector normalize(DVector target) {
    if (target == null) {
      target = new DVector();
    }
    double m = mag();
    if (m > 0) {
      target.set(x/m, y/m, z/m);
    } else {
      target.set(x, y, z);
    }
    return target;
  }


  public DVector limit(double max) {
    if (magSq() > max*max) {
      normalize();
      mult(max);
    }
    return this;
  }


  public DVector setMag(double len) {
    normalize();
    mult(len);
    return this;
  }


  public DVector setMag(DVector target, double len) {
    target = normalize(target);
    target.mult(len);
    return target;
  }


  public double heading() {
    double angle = (double) Math.atan2(y, x);
    return angle;
  }



/*

  public DVector rotate(double theta) {
    double temp = x;
    // Might need to check for rounding errors like with angleBetween function?
    x = x*PApplet.cos((float)theta) - y*PApplet.sin((float)theta);
    y = temp*PApplet.sin((float)theta) + y*PApplet.cos((float)theta);
    return this;
  }


  public DVector lerp(DVector v, double amt) {
    x = PApplet.lerp(x, v.x, amt);
    y = PApplet.lerp(y, v.y, amt);
    z = PApplet.lerp(z, v.z, amt);
    return this;
  }


  
   /* Linear interpolate between two vectors (returns a new DVector object)
   /* @param v1 the vector to start from
   /* @param v2 the vector to lerp to
 
  public static DVector lerp(DVector v1, DVector v2, double amt) {
    DVector v = v1.copy();
    v.lerp(v2, amt);
    return v;
  }


  /**
   * Linear interpolate the vector to x,y,z values
   * @param x the x component to lerp to
   * @param y the y component to lerp to
   * @param z the z component to lerp to
  
  public DVector lerp(double x, double y, double z, double amt) {
    this.x = PApplet.lerp(this.x, x, amt);
    this.y = PApplet.lerp(this.y, y, amt);
    this.z = PApplet.lerp(this.z, z, amt);
    return this;
  }

*/

  /**
   * ( begin auto-generated from DVector_angleBetween.xml )
   *
   * Calculates and returns the angle (in radians) between two vectors.
   *
   * ( end auto-generated )
   *
   * @webref DVector:method
   * @usage web_application
   * @param v1 the x, y, and z components of a DVector
   * @param v2 the x, y, and z components of a DVector
   * @brief Calculate and return the angle between two vectors
   */
 double angleBetween(DVector v1, DVector v2) {

    // We get NaN if we pass in a zero vector which can cause problems
    // Zero seems like a reasonable angle between a (0,0,0) vector and something else
    if (v1.x == 0 && v1.y == 0 && v1.z == 0 ) return 0.0f;
    if (v2.x == 0 && v2.y == 0 && v2.z == 0 ) return 0.0f;

    double dot = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
    double v1mag = Math.sqrt(v1.x * v1.x + v1.y * v1.y + v1.z * v1.z);
    double v2mag = Math.sqrt(v2.x * v2.x + v2.y * v2.y + v2.z * v2.z);
    // This should be a number between -1 and 1, since it's "normalized"
    double amt = dot / (v1mag * v2mag);
    // But if it's not due to rounding error, then we need to fix it
    // http://code.google.com/p/processing/issues/detail?id=340
    // Otherwise if outside the range, acos() will return NaN
    // http://www.cppreference.com/wiki/c/math/acos
    if (amt <= -1) {
      return PConstants.PI;
    } else if (amt >= 1) {
      // http://code.google.com/p/processing/issues/detail?id=435
      return 0;
    }
    return (double) Math.acos(amt);
  }


  @Override
  public String toString() {
    return "[ " + x + ", " + y + ", " + z + " ]";
  }


  /**
   * ( begin auto-generated from DVector_array.xml )
   *
   * Return a representation of this vector as a double array. This is only
   * for temporary use. If used in any other fashion, the contents should be
   * copied by using the <b>DVector.get()</b> method to copy into your own array.
   *
   * ( end auto-generated )
   *
   * @webref DVector:method
   * @usage: web_application
   * @brief Return a representation of the vector as a double array
   */
  public double[] array() {
    if (array == null) {
      array = new double[3];
    }
    array[0] = x;
    array[1] = y;
    array[2] = z;
    return array;
  }


  @Override
  public boolean equals(Object obj) {
    if (!(obj instanceof DVector)) {
      return false;
    }
    final DVector p = (DVector) obj;
    return x == p.x && y == p.y && z == p.z;
  }


  @Override
  public int hashCode() {
    double result = 1;
    result = 31 * result + Double.doubleToLongBits(x);
    result = 31 * result + Double.doubleToLongBits(y);
    result = 31 * result + Double.doubleToLongBits(z);
    return (int)result;
  }
}
