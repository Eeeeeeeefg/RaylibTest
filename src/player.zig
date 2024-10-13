const rl = @import("raylib");
const keys = rl.KeyboardKey;

pub const player = struct {
    rect: rl.Rectangle,
    color: rl.Color,
    id: u8,
    moveBools: [4]bool,
    //[0] is right, [1] is left, [2] is up, [3] is down
    k: struct {
        up: keys,
        down: keys,
        left: keys,
        right: keys,
    },
};

pub fn reset(p: *player) !void {
    p.rect.x = 400;
    p.rect.y = 450 / 2;
}

pub fn Move(p: *player) !void {
    //if (rl.isKeyDown(p.k.right) and p.moveBools[0]) {
    //    p.rect.x += 5;
    //} else {}
    //if (rl.isKeyDown(p.k.left) and p.moveBools[1]) {
    //    p.rect.x -= 5;
    //} else {}

    if (rl.isKeyDown(p.k.up) and p.moveBools[2]) {
        p.rect.y -= 5;
    } else {}
    if (rl.isKeyDown(p.k.down) and p.moveBools[3]) {
        p.rect.y += 5;
    } else {}
}

pub fn screenBounds(p: *player) !void {
    //right boundary
    if (p.rect.x >= 1125) {
        p.moveBools[0] = false;
    } else {
        p.moveBools[0] = true;
    }
    //left boundary
    if (p.rect.x <= 0) {
        p.moveBools[1] = false;
    } else {
        p.moveBools[1] = true;
    }
    //top boundary
    if (p.rect.y <= 0) {
        p.moveBools[2] = false;
    } else {
        p.moveBools[2] = true;
    }
    //bottom boundary
    if (p.rect.y >= 525) {
        p.moveBools[3] = false;
    } else {
        p.moveBools[3] = true;
    }
}
