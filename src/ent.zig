const rl = @import("raylib");
const swidth = 1600;
const sheight = 600;

pub const Ball = struct {
    rect: rl.Rectangle,
    velocity: rl.Vector2,
    color: rl.Color = rl.Color.white,

    pub fn move(self: *Ball) !void {
        //x axis movement
        if (!(self.rect.x <= 0 or self.rect.x + self.rect.width >= swidth)) {
            self.rect.x += self.velocity.x;
        } else {}
        //y axis movement
        if (!(self.rect.y - self.rect.height <= 0 or self.rect.y + self.rect.height >= sheight)) {
            self.rect.y += self.velocity.y;
        } else {}
    }

    pub fn collide(self: *Ball, sw: comptime_int, sh: comptime_int) !void {
        //should reverse the velocity if it touches a screenBound
        //x axis works, y doesn't
        if (self.rect.x - self.rect.width <= 0 or self.rect.x >= sw - self.rect.width) {
            self.velocity.x = self.velocity.x * -1;
        } else {}
        if (self.rect.y - self.rect.height <= 0 or self.rect.y + self.rect.height >= sh) {
            self.velocity.y = self.velocity.y * -1;
        }
    }
};
