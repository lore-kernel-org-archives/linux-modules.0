Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277739CD08;
	Sun, 11 Oct 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723189; cv=none; b=bMdNJTjn3apfvuT4xmB0sBxz10tLSTwdGg0YKTTt+ttS3W5nSEUQb5sp0EOblUXYMhjwCLdHOY40bNRRJJv/DsRT0WtUtI9QmVdRqKTbiHjG4F/N/AXbvqC+aY3lbxEsQwrLDDRIkNEFX/LbuBsZGgopYavgVSlypbqu0plKeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723189; c=relaxed/simple;
	bh=ltM38puMFweObhkPk2+jAoqwDneuuHsqc/rfWWFdm6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oE3zwCparbDsJYzs3laeQ8Eww2SwkXlUg3JcnKDupgUwO3s/hvW/8EJYd5K8sfAPUrteZmLdm79SyFV5dlfZW8f0xURSe2KihTD88mKUhrjxthSKHP3rYysZ0YL2+Si+mVt1Ybr22rfI9H+nwyFgF2U5P42BhlF+udZHYCV2nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JH/Qlwi4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JH/Qlwi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723178;
	bh=ltM38puMFweObhkPk2+jAoqwDneuuHsqc/rfWWFdm6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JH/Qlwi4KWvyGkAOrLZhYizUurtSZ6PVYlOtVPi+YR6/3nfpzElfFfGifOfN7igAi
	 GfUO2KxDI2w6SziXHxiVwcXhl0lJWy+Nu46LX86fqUTZ/etC6fqwa4D5gzAuZmkxI7
	 e2S8UHei8gS4qNifVNzVqI1ctVC1F5rHIlwzNsEQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:26 +0200
Subject: [PATCH RFC 02/11] rust: sync: atomic: Add Atomic<u{8,16}>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-2-832e4039b71f@weissschuh.net>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
To: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=4599;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ltM38puMFweObhkPk2+jAoqwDneuuHsqc/rfWWFdm6s=;
 b=KacfSUzLxUTfSpNb3KNKB+bdejnjWLAEwokqYM61iHbJUi/zOd+4O4wnMJxt1F5uwoseV07u3
 oJT8f/P96HYAJs2RBr6T3eGbueyvzazQ/My9/e3tlFcs/9XqvvCK35C
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add generic atomic support for small unsigned integers that have an
`AtomicImpl` with the same size and alignment.

Also extend the unit tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/sync/atomic/predefine.rs | 44 ++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 3d63f40791fa..4c1fb5e08dc2 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -113,6 +113,32 @@ fn rhs_into_delta(rhs: isize) -> isize_atomic_repr {
     }
 }
 
+// SAFETY: `u8` and `i8` has the same size and alignment, and `u8` is round-trip transmutable to
+// `i8`.
+unsafe impl super::AtomicType for u8 {
+    type Repr = i8;
+}
+
+// SAFETY: The wrapping add result of two `i8`s is a valid `u8`.
+unsafe impl super::AtomicAdd<u8> for u8 {
+    fn rhs_into_delta(rhs: u8) -> i8 {
+        rhs as i8
+    }
+}
+
+// SAFETY: `u16` and `i16` has the same size and alignment, and `u16` is round-trip transmutable to
+// `i16`.
+unsafe impl super::AtomicType for u16 {
+    type Repr = i16;
+}
+
+// SAFETY: The wrapping add result of two `i16`s is a valid `u16`.
+unsafe impl super::AtomicAdd<u16> for u16 {
+    fn rhs_into_delta(rhs: u16) -> i16 {
+        rhs as i16
+    }
+}
+
 // SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
 // `i32`.
 unsafe impl super::AtomicType for u32 {
@@ -170,13 +196,13 @@ macro_rules! for_each_type {
 
     #[test]
     fn atomic_basic_tests() {
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.load(Relaxed));
         });
 
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
             let ptr = x.as_ptr();
 
@@ -187,14 +213,14 @@ fn atomic_basic_tests() {
 
     #[test]
     fn atomic_acquire_release_tests() {
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(0);
 
             x.store(v, Release);
             assert_eq!(v, x.load(Acquire));
         });
 
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(0);
             let ptr = x.as_ptr();
 
@@ -208,7 +234,7 @@ fn atomic_acquire_release_tests() {
 
     #[test]
     fn atomic_xchg_tests() {
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -218,7 +244,7 @@ fn atomic_xchg_tests() {
             assert_eq!(new, x.load(Relaxed));
         });
 
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
             let ptr = x.as_ptr();
 
@@ -233,7 +259,7 @@ fn atomic_xchg_tests() {
 
     #[test]
     fn atomic_cmpxchg_tests() {
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             let old = v;
@@ -245,7 +271,7 @@ fn atomic_cmpxchg_tests() {
             assert_eq!(new, x.load(Relaxed));
         });
 
-        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i8, i16, i32, i64, u8, u16, u32, u64, isize, usize] |v| {
             let x = Atomic::new(v);
             let ptr = x.as_ptr();
 
@@ -263,7 +289,7 @@ fn atomic_cmpxchg_tests() {
 
     #[test]
     fn atomic_arithmetic_tests() {
-        for_each_type!(42 in [i32, i64, u32, u64, isize, usize] |v| {
+        for_each_type!(42 in [i32, i64, u64, isize, usize] |v| {
             let x = Atomic::new(v);
 
             assert_eq!(v, x.fetch_add(12, Full));

-- 
2.56.0

