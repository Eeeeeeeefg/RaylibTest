const rl = @import("raylib");
const keys = rl.KeyboardKey;
const _p = @import("player.zig");
const ent = @import("ent.zig");

var P = _p.player{
    .rect = rl.Rectangle.init(100, 300, 15, 100),
    .color = rl.Color.red,
    .id = 1,
    .moveBools = [4]bool{ true, true, true, true },
    .k = .{
        .up = keys.key_w,
        .down = keys.key_s,
        .left = keys.key_a,
        .right = keys.key_d,
    },
};

var P2 = _p.player{ .rect = rl.Rectangle.init(1100, 300, 15, 100), .color = rl.Color.green, .id = 2, .moveBools = [4]bool{ true, true, true, true }, .k = .{
    .up = keys.key_up,
    .down = keys.key_down,
    .left = keys.key_left,
    .right = keys.key_right,
} };

var ball = ent.Ball{ .rect = rl.Rectangle.init(swidth / 2, sheight / 2, 10, 10), .velocity = rl.Vector2.init(5, 5) };

const swidth = 1200;
const sheight = 600;

pub fn main() anyerror!void {
    rl.initWindow(swidth, sheight, "whats good my gs");
    defer rl.closeWindow();

    rl.setTargetFPS(60);
    var ctr: u8 = 0;

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();
        if (ctr <= 255) {
            ctr = 0;
        } else {
            ctr += 1;
        }

        if (ctr % 4 == 0) {
            try physicsLoop();
        } else {}

        rl.clearBackground(rl.Color.blue);
        rl.drawRectangleRec(P.rect, P.color);
        rl.drawRectangleRec(P2.rect, P2.color);
        rl.drawRectangleRec(ball.rect, ball.color);
    }
}

fn physicsLoop() !void {
    try _p.Move(&P);
    try _p.screenBounds(&P);
    try _p.Move(&P2);
    try _p.screenBounds(&P2);
    try ball.collide(swidth, sheight);
    try ball.move();
}
