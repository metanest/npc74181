module npc74181 (m, s, a, b, ci, o, zf, co, cp, cg);
   input m;
   input [3:0] s, a, b;
   input ci;

   output [3:0] o;
   output zf, co, cp, cg;

   wire [3:0] s0 = {s[0], s[0], s[0], s[0]};
   wire [3:0] s1 = {s[1], s[1], s[1], s[1]};
   wire [3:0] s2 = {s[2], s[2], s[2], s[2]};
   wire [3:0] s3 = {s[3], s[3], s[3], s[3]};

   wire [3:0] v = ((a & ~b) & s0) | ((a &  b) & s1);
   wire [3:0] u = a | (b & s2) | (~b & s3);

   wire c1 = |{ &{m, v[0]}, &{m, u[0], ci} };
   wire c2 = |{ &{m, v[1]}, &{m, u[1], v[0]}, &{m, u[1:0], ci} };
   wire c3 = |{ &{m, v[2]}, &{m, u[2], v[1]}, &{m, u[2:1], v[0]}, &{m, u[2:0], ci} };

   wire [3:0] o_ = (u ^ v) ^ {c3, c2, c1, m&ci};
   wire cg_ = |{ v[3], &{u[3], v[2]}, &{u[3:2], v[1]}, &{u[3:1], v[0]} };

   assign o = o_;
   assign zf = ~(|o_);
   assign co = cg_ | &{ u, ci };
   assign cp = &u;
   assign cg = cg_;
endmodule
