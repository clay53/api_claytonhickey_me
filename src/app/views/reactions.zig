const std = @import("std");
const jetzig = @import("jetzig");

pub fn get(id: []const u8, request: *jetzig.Request) !jetzig.View {
    _ = id;
    var root = try request.data(.object);
    try root.put("❤️", 1);
    return request.render(.ok);
}

pub fn patch(id: []const u8, request: *jetzig.Request) !jetzig.View {
    _ = id;
    return request.render(.ok);
}

test "get" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/reactions/example-id", .{});
    try response.expectStatus(.ok);
}

test "patch" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.PATCH, "/reactions/example-id", .{});
    try response.expectStatus(.ok);
}
