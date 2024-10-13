const rl = @import("raylib");
const swidth = 1600;
const sheight = 600;

pub const Ball = struct {
    rect: rl.Rectangle,
    velocity: rl.Vector2,
    color: rl.Color = rl.Color.white,
    moveBools: [4]bool = [4]bool{ true, true, true, true },

    pub fn move(self: *Ball) !void {
        //x axis movement
        if (self.moveBools[0] or self.moveBools[1]) {
            self.rect.x += self.velocity.x;
        } else {}
        //y axis movement
        if (self.moveBools[2] or self.moveBools[3]) {
            self.rect.y += self.velocity.y;
        } else {}
    }

    pub fn screenBounds(self: *Ball) !void {
        //right boundary
        if (self.rect.x >= swidth - rl.Rectangle.width) {
            self.moveBools[0] = false;
            self.rect.x -= 15;
        } else {
            self.moveBools[0] = true;
        }
        //left boundary
        if (self.rect.x <= 0) {
            self.moveBools[1] = false;
            self.rect.y += 15;
        } else {
            self.moveBools[1] = true;
        }
        //top boundary
        if (self.rect.y <= 0) {
            self.moveBools[2] = false;
            self.rect.y += 15;
        } else {
            self.moveBools[2] = true;
        }
        //bottom boundary
        if (self.rect.y >= sheight - rl.Rectangle.height) {
            self.moveBools[3] = false;
            self.rect.y -= 15;
        } else {
            self.moveBools[3] = true;
        }
    }

    pub fn collide(self: *Ball, sw: comptime_int, sh: comptime_int) !void {
        //should reverse the velocity if it touches a screenBound
        //x axis works, y doesn't
        if (self.rect.x <= 0 or self.rect.x >= sw) {
            self.velocity.x = self.velocity.x * -1;
        } else {}
        if (self.rect.y <= 0 or self.rect.y >= sh) {
            self.rect.y = self.rect.y * -1;
        }
    }
};
