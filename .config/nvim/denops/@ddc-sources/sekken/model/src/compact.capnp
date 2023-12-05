@0xe53731c862edacd2;

struct CompactModel {
  entries @0 :List(Entry);
  struct Entry {
    key @0 :UInt64;
    value @1 :UInt8;
  }
}
