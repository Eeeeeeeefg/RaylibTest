const rl = @import("raylib");
const keys = rl.KeyboardKey;

pub fn main() anyerror!void {
    const swidth = 800;
    const sheight = 450;

    const gravity = 4;

    rl.initWindow(swidth, sheight, "whats good my gs");
    defer rl.closeWindow();

    var ballPos = rl.Vector2.init(swidth / 2, sheight / 2);

    rl.setTargetFPS(60);

    var moveBools = [4]bool{ true, true, true, true };
    //[0] is right, [1] is left, [2] is up, [3] is down

    while (!rl.windowShouldClose()) {
        if (rl.isKeyDown(keys.key_r)) {
            try reset(&ballPos);
        }

        //handles movement
        try screenBounds(&ballPos, &moveBools);
        try ballMove(&ballPos, &moveBools);

        if (ballPos.y <= 400) {
            ballPos.y += gravity;
        } else {}

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.blue);
        rl.drawCircleV(ballPos, 50, rl.Color.red);
    }
}

pub fn reset(vec: *rl.Vector2) !void {
    vec.x = 400;
    vec.y = 450 / 2;
}

pub fn ballMove(vec: *rl.Vector2, moveBools: []bool) !void {
    if (rl.isKeyDown(keys.key_d) and moveBools[0]) {
        vec.x += 5;
    } else {}
    if (rl.isKeyDown(keys.key_a) and moveBools[1]) {
        vec.x -= 5;
    } else {}

    if (rl.isKeyDown(keys.key_w) and moveBools[2]) {
        vec.y -= 5;
    } else {}
    if (rl.isKeyDown(keys.key_s) and moveBools[3]) {
        vec.y += 5;
    } else {}
}

pub fn screenBounds(vec: *rl.Vector2, moveBools: []bool) !void {
    if (vec.x >= 750) {
        moveBools[0] = false;
    } else {
        moveBools[0] = true;
    }
    if (vec.x <= 50) {
        moveBools[1] = false;
    } else {
        moveBools[1] = true;
    }
    if (vec.y <= 50) {
        moveBools[2] = false;
    } else {
        moveBools[2] = true;
    }
    if (vec.y >= 400) {
        moveBools[3] = false;
    } else {
        moveBools[3] = true;
    }
}
