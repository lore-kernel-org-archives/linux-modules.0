Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C82512C8
	for <linux-modules@vger.kernel.org>; Thu,  1 Jan 2026 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767244916; cv=none; b=eCL1OA1HOOaaRB1C2NBgxlaZ+p7eLK6Ms7sXwpJCoDxnLV6bXTohSt9yQfDR/fN0sUYLnx++w2+0RZBqimjiA/bB1PF+Q6omYXFH+RWLz9uj79aJzmAFxXt/ZFN2+hSniMFmDr7FQljcbqz4ndB2CLKHl0RlmaK3TBqXIpcd1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767244916; c=relaxed/simple;
	bh=7rhNZKoiKt69rXYOx/nPj8NyhjOaV5my4mHPW2W+MJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8V+cj0cjeKOUoNSBu3f9A+KMM+F3pxcIulOEThIr67U9YhflbwDbkBB02SXRwkj/x50j7ejw5dTn8E8o++hw61PedZBn3/rCABSEfrZhhMEwurJWJE+mmemN7aFLCjTD5GyqyvJNgLdALOR7apWLG+69EbNljXACYzYXPt/Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr2pmb9f; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr2pmb9f"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so72507091fa.1
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 21:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767244911; x=1767849711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnWuhRewCBtlepNlYLvDYAkJsMsIyPpraMiTNGgUITs=;
        b=lr2pmb9fBA3ugs/QR3Y2DjR/7jhhFex3Bml0m8fWx3JIlEE/Naj4CCVxWlbFOY5qSf
         4xsINTZRn4KBLoC6EWlnV/FJdu+6fNEbdvkPPpwPMYWa+LKygDQK2iWWV9FVWg+RQgtx
         2bWp5goviPCxIL9+m2T6KC4zxzmvi6kIQGreyl3kD2kDWjHEjZr1+TBU6rjBaCmU4Zrk
         oFkxvaaooR7/DOjrZmPFHWEmow+5xJLqXjQT9NHsMWdAX34K8fiMfI2AO6n6yoWLVNsD
         DVMi360hK39YLVb8Oo88j+nlXyvZh3yeOlQtuUsmBFfd7ubmHBvukKn/QdrbVxT7VunQ
         5fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767244911; x=1767849711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZnWuhRewCBtlepNlYLvDYAkJsMsIyPpraMiTNGgUITs=;
        b=Bi1/47rkEhf381SNwr26n2lB2s36X4UkIUeuIHc3jWVKbbf336v76D08pL7ga7OIKE
         sOvO1uz/7JAbJ+aHpWe9fBRQ4hcgkg7In371gnTufC7Qm/iw0pgH+tSgX7O5fjLEHcIT
         PNqP1lUspL89c2Z7hVQXDPUfLiwwDjmzl0dKxEIfAoC3Haf0tOMeYgA8Ljusdyk8VZg0
         6YnTeSjxd8aEsKmt/gln1nWYhoK4jRJSA1ZI3JAwflJo9UbK6UElYAVU5vkXEE53J72L
         m5G1qTUDhaZHXvNMdVR7S8Tx9zDzqlt7w9rfcRc2en99Ydg6pXTSAmVPxGlbWGzoXelh
         v9zg==
X-Forwarded-Encrypted: i=1; AJvYcCWiInTdbxLLsbEzcv+SR82Lxj0TWORcA8UDe5fY4xW36ecfu9wP5VpqPghTf3Ltp0/7PKif24PqVChImt/4@vger.kernel.org
X-Gm-Message-State: AOJu0YzerrVusPjrh5cjiLTt8Dyi7gj6oBiNkQ6lGsNkafqhWHoQ2r/i
	R3nUsWb11MiCEXi0AgGT/3JM9uYFwg3vdaAxAe2rY5NgqTE1jV1bX5oD
X-Gm-Gg: AY/fxX4G4q60Me1Tt8c+DjR+MQRgiYYEqi3f9zLM0N89u9I+GL3HlQtO/uf1SLxfb1q
	jTRP6V4Jb3kHZ2f8NnIfYXjLYXdWZDMzx6d1jBEbg8wDbiKg61drffIBwX4MOIUmOCwzn7Tmtad
	xtS1SVPVYIVGdw5o0Xx5UreZAn7DMUhcQIaYqYyjiLbAh8dmB6+Qz+/mYvMKp4jOvMozD9RmlB9
	XY9rja7Xs7iY1H4UPCaoFMkoYNDgELr0x4M7U4jQn1MER56juDrkFFY91qLlE9eV1IYpsk1OYQX
	O2CLOasLChE3IHWf3CvWgAyuYij7CtXpd7ZU5JTmAu/PYSLETbtW6VHgxjGudaz3Z65cFuMtUZJ
	ecawbqAXX+OLYr52FPYJxCddw1E+k9yYSNNUYxubwyZmkOkJ/7Oh6zfJNsc+UTwtTIhDKwKIJSw
	MRLtCXxo+Kq9sLwRDJKKltn9IYhqpXk1TCym5XZiZEHexnuXZe1rqtLgc4xQpMpu1KoHAroxV/l
	2gO5XPTPu7OFyg2
X-Google-Smtp-Source: AGHT+IGWnxKTzBFDRvVhBJLkPNrg5zCvovKVt3Iq5ajcHW0NwDfpLyHHuTaAQOvw6Ai3P24W4z2g9Q==
X-Received: by 2002:a05:651c:1443:b0:382:4d6b:993b with SMTP id 38308e7fff4ca-3824d6b9c18mr83313231fa.35.1767244910574;
        Wed, 31 Dec 2025 21:21:50 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (84-253-216-54.bb.dnainternet.fi. [84.253.216.54])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382861ef4ccsm37064921fa.23.2025.12.31.21.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 21:21:48 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 01 Jan 2026 07:20:49 +0200
Subject: [PATCH RFC 5/6] rust: debugfs: WIP: Use owner for file_operations
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-this_module_fix-v1-5-46ae3e5605a0@gmail.com>
References: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
In-Reply-To: <20260101-this_module_fix-v1-0-46ae3e5605a0@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jens Axboe <axboe@kernel.dk>, Kari Argillander <kari.argillander@gmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767244881; l=16426;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=7rhNZKoiKt69rXYOx/nPj8NyhjOaV5my4mHPW2W+MJo=;
 b=/FHxPndxLye7RpOlj19HW54w3416yImg7K+iPDUzBUCprQvFxJNDtczJD3uQwfT7CmWNxIUe6
 6iglF8d4oCDCqSX4wSpusPl5a2PMwxaVFMFe5smUbzFzPC75Rg8FCPo
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

---
 rust/kernel/debugfs.rs          | 79 ++++++++++++++++++++++-------------------
 rust/kernel/debugfs/file_ops.rs | 50 +++++++++++++++++++-------
 samples/rust/rust_debugfs.rs    |  6 ++--
 3 files changed, 83 insertions(+), 52 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index facad81e8290..03e22b1cfa2b 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -6,7 +6,8 @@
 //! C header: [`include/linux/debugfs.h`](srctree/include/linux/debugfs.h)
 
 // When DebugFS is disabled, many parameters are dead. Linting for this isn't helpful.
-#![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
+// #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
+#![allow(unused_variables)]
 
 use crate::fmt;
 use crate::prelude::*;
@@ -46,27 +47,31 @@
 // able to refer to us. In this case, we need to silently fail. All future child directories/files
 // will silently fail as well.
 #[derive(Clone)]
-pub struct Dir(#[cfg(CONFIG_DEBUG_FS)] Option<Arc<Entry<'static>>>);
+pub struct Dir<M: ThisModule>(
+    #[cfg(CONFIG_DEBUG_FS)] Option<Arc<Entry<'static>>>,
+    PhantomData<M>,
+);
 
-impl Dir {
+impl<M: ThisModule> Dir<M> {
     /// Create a new directory in DebugFS. If `parent` is [`None`], it will be created at the root.
-    fn create(name: &CStr, parent: Option<&Dir>) -> Self {
+    fn create(name: &CStr, parent: Option<&Self>) -> Self {
         #[cfg(CONFIG_DEBUG_FS)]
         {
             let parent_entry = match parent {
                 // If the parent couldn't be allocated, just early-return
-                Some(Dir(None)) => return Self(None),
-                Some(Dir(Some(entry))) => Some(entry.clone()),
+                Some(Self(None, _)) => return Self(None, PhantomData),
+                Some(Self(Some(entry), _)) => Some(entry.clone()),
                 None => None,
             };
             Self(
                 // If Arc creation fails, the `Entry` will be dropped, so the directory will be
                 // cleaned up.
                 Arc::new(Entry::dynamic_dir(name, parent_entry), GFP_KERNEL).ok(),
+                PhantomData,
             )
         }
         #[cfg(not(CONFIG_DEBUG_FS))]
-        Self()
+        Self(PhantomData)
     }
 
     /// Creates a DebugFS file which will own the data produced by the initializer provided in
@@ -107,7 +112,7 @@ fn create_file<'a, T, E: 'a>(
     /// let debugfs = Dir::new(c_str!("parent"));
     /// ```
     pub fn new(name: &CStr) -> Self {
-        Dir::create(name, None)
+        Self::create(name, None)
     }
 
     /// Creates a subdirectory within this directory.
@@ -121,7 +126,7 @@ pub fn new(name: &CStr) -> Self {
     /// let child = parent.subdir(c_str!("child"));
     /// ```
     pub fn subdir(&self, name: &CStr) -> Self {
-        Dir::create(name, Some(self))
+        Self::create(name, Some(self))
     }
 
     /// Creates a read-only file in this directory.
@@ -149,7 +154,7 @@ pub fn read_only_file<'a, T, E: 'a>(
     where
         T: Writer + Send + Sync + 'static,
     {
-        let file_ops = &<T as ReadFile<_>>::FILE_OPS;
+        let file_ops = &<T as ReadFile<M, _>>::FILE_OPS;
         self.create_file(name, data, file_ops)
     }
 
@@ -176,7 +181,7 @@ pub fn read_binary_file<'a, T, E: 'a>(
     where
         T: BinaryWriter + Send + Sync + 'static,
     {
-        self.create_file(name, data, &T::FILE_OPS)
+        self.create_file(name, data, &<T as BinaryReadFile<M, _>>::FILE_OPS)
     }
 
     /// Creates a read-only file in this directory, with contents from a callback.
@@ -215,7 +220,7 @@ pub fn read_callback_file<'a, T, E: 'a, F>(
         T: Send + Sync + 'static,
         F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
     {
-        let file_ops = <FormatAdapter<T, F>>::FILE_OPS.adapt();
+        let file_ops = <FormatAdapter<T, F> as ReadFile<M, FormatAdapter<T, F>>>::FILE_OPS.adapt();
         self.create_file(name, data, file_ops)
     }
 
@@ -231,7 +236,7 @@ pub fn read_write_file<'a, T, E: 'a>(
     where
         T: Writer + Reader + Send + Sync + 'static,
     {
-        let file_ops = &<T as ReadWriteFile<_>>::FILE_OPS;
+        let file_ops = &<T as ReadWriteFile<M, _>>::FILE_OPS;
         self.create_file(name, data, file_ops)
     }
 
@@ -247,7 +252,7 @@ pub fn read_write_binary_file<'a, T, E: 'a>(
     where
         T: BinaryWriter + BinaryReader + Send + Sync + 'static,
     {
-        let file_ops = &<T as BinaryReadWriteFile<_>>::FILE_OPS;
+        let file_ops = &<T as BinaryReadWriteFile<M, _>>::FILE_OPS;
         self.create_file(name, data, file_ops)
     }
 
@@ -270,7 +275,7 @@ pub fn read_write_callback_file<'a, T, E: 'a, F, W>(
         W: Fn(&T, &mut UserSliceReader) -> Result + Send + Sync,
     {
         let file_ops =
-            <WritableAdapter<FormatAdapter<T, F>, W> as file_ops::ReadWriteFile<_>>::FILE_OPS
+            <WritableAdapter<FormatAdapter<T, F>, W> as file_ops::ReadWriteFile<M, _>>::FILE_OPS
                 .adapt()
                 .adapt();
         self.create_file(name, data, file_ops)
@@ -290,7 +295,7 @@ pub fn write_only_file<'a, T, E: 'a>(
     where
         T: Reader + Send + Sync + 'static,
     {
-        self.create_file(name, data, &T::FILE_OPS)
+        self.create_file(name, data, &<T as WriteFile<M, _>>::FILE_OPS)
     }
 
     /// Creates a write-only binary file in this directory.
@@ -307,7 +312,7 @@ pub fn write_binary_file<'a, T, E: 'a>(
     where
         T: BinaryReader + Send + Sync + 'static,
     {
-        self.create_file(name, data, &T::FILE_OPS)
+        self.create_file(name, data, &<T as BinaryWriteFile<M, _>>::FILE_OPS)
     }
 
     /// Creates a write-only file in this directory, with write logic from a callback.
@@ -324,7 +329,7 @@ pub fn write_callback_file<'a, T, E: 'a, W>(
         T: Send + Sync + 'static,
         W: Fn(&T, &mut UserSliceReader) -> Result + Send + Sync,
     {
-        let file_ops = <WritableAdapter<NoWriter<T>, W> as WriteFile<_>>::FILE_OPS
+        let file_ops = <WritableAdapter<NoWriter<T>, W> as WriteFile<M, _>>::FILE_OPS
             .adapt()
             .adapt();
         self.create_file(name, data, file_ops)
@@ -527,7 +532,7 @@ fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: &'static Fil
     /// file is removed when the [`Scope`] that this directory belongs
     /// to is dropped.
     pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name: &CStr, data: &'data T) {
-        self.create_file(name, data, &T::FILE_OPS)
+        // self.create_file(name, data, &<T as ReadFile<M, T>>::FILE_OPS)
     }
 
     /// Creates a read-only binary file in this directory.
@@ -541,7 +546,7 @@ pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
         name: &CStr,
         data: &'data T,
     ) {
-        self.create_file(name, data, &T::FILE_OPS)
+        // self.create_file(name, data, &<T as ReadFile<M, T>>::FILE_OPS)
     }
 
     /// Creates a read-only file in this directory, with contents from a callback.
@@ -560,8 +565,8 @@ pub fn read_callback_file<T, F>(&self, name: &CStr, data: &'data T, _f: &'static
         T: Send + Sync + 'static,
         F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
     {
-        let vtable = <FormatAdapter<T, F> as ReadFile<_>>::FILE_OPS.adapt();
-        self.create_file(name, data, vtable)
+        // let vtable = <FormatAdapter<T, F> as ReadFile<M, _>>::FILE_OPS.adapt();
+        // self.create_file(name, data, vtable)
     }
 
     /// Creates a read-write file in this directory.
@@ -577,8 +582,8 @@ pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
         name: &CStr,
         data: &'data T,
     ) {
-        let vtable = &<T as ReadWriteFile<_>>::FILE_OPS;
-        self.create_file(name, data, vtable)
+        // let vtable = &<T as ReadWriteFile<_>>::FILE_OPS;
+        // self.create_file(name, data, vtable)
     }
 
     /// Creates a read-write binary file in this directory.
@@ -593,8 +598,8 @@ pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send + Sync + 'st
         name: &CStr,
         data: &'data T,
     ) {
-        let vtable = &<T as BinaryReadWriteFile<_>>::FILE_OPS;
-        self.create_file(name, data, vtable)
+        // let vtable = &<T as BinaryReadWriteFile<_>>::FILE_OPS;
+        // self.create_file(name, data, vtable)
     }
 
     /// Creates a read-write file in this directory, with logic from callbacks.
@@ -618,10 +623,10 @@ pub fn read_write_callback_file<T, F, W>(
         F: Fn(&T, &mut fmt::Formatter<'_>) -> fmt::Result + Send + Sync,
         W: Fn(&T, &mut UserSliceReader) -> Result + Send + Sync,
     {
-        let vtable = <WritableAdapter<FormatAdapter<T, F>, W> as ReadWriteFile<_>>::FILE_OPS
-            .adapt()
-            .adapt();
-        self.create_file(name, data, vtable)
+        // let vtable = <WritableAdapter<FormatAdapter<T, F>, W> as ReadWriteFile<_>>::FILE_OPS
+        //     .adapt()
+        //     .adapt();
+        // self.create_file(name, data, vtable)
     }
 
     /// Creates a write-only file in this directory.
@@ -632,8 +637,8 @@ pub fn read_write_callback_file<T, F, W>(
     /// file is removed when the [`Scope`] that this directory belongs
     /// to is dropped.
     pub fn write_only_file<T: Reader + Send + Sync + 'static>(&self, name: &CStr, data: &'data T) {
-        let vtable = &<T as WriteFile<_>>::FILE_OPS;
-        self.create_file(name, data, vtable)
+        // let vtable = &<T as WriteFile<_>>::FILE_OPS;
+        // self.create_file(name, data, vtable)
     }
 
     /// Creates a write-only binary file in this directory.
@@ -647,7 +652,7 @@ pub fn write_binary_file<T: BinaryReader + Send + Sync + 'static>(
         name: &CStr,
         data: &'data T,
     ) {
-        self.create_file(name, data, &T::FILE_OPS)
+        // self.create_file(name, data, &<T as ReadFile<M, T>>::FILE_OPS)
     }
 
     /// Creates a write-only file in this directory, with write logic from a callback.
@@ -665,10 +670,10 @@ pub fn write_only_callback_file<T, W>(&self, name: &CStr, data: &'data T, _w: &'
         T: Send + Sync + 'static,
         W: Fn(&T, &mut UserSliceReader) -> Result + Send + Sync,
     {
-        let vtable = &<WritableAdapter<NoWriter<T>, W> as WriteFile<_>>::FILE_OPS
-            .adapt()
-            .adapt();
-        self.create_file(name, data, vtable)
+        // let vtable = &<WritableAdapter<NoWriter<T>, W> as WriteFile<_>>::FILE_OPS
+        //     .adapt()
+        //     .adapt();
+        // self.create_file(name, data, vtable)
     }
 
     fn empty() -> Self {
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 8a0442d6dd7a..0e5059c044af 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -115,13 +115,14 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 // Work around lack of generic const items.
-pub(crate) trait ReadFile<T> {
+pub(crate) trait ReadFile<M, T> {
     const FILE_OPS: FileOps<T>;
 }
 
-impl<T: Writer + Sync> ReadFile<T> for T {
+impl<M: ThisModule, T: Writer + Sync> ReadFile<M, T> for T {
     const FILE_OPS: FileOps<T> = {
         let operations = bindings::file_operations {
+            owner: M::OWNER.as_ptr(),
             read: Some(bindings::seq_read),
             llseek: Some(bindings::seq_lseek),
             release: Some(bindings::single_release),
@@ -167,13 +168,18 @@ fn read<T: Reader + Sync>(data: &T, buf: *const c_char, count: usize) -> isize {
 }
 
 // A trait to get the file operations for a type.
-pub(crate) trait ReadWriteFile<T> {
+pub(crate) trait ReadWriteFile<M, T> {
     const FILE_OPS: FileOps<T>;
 }
 
-impl<T: Writer + Reader + Sync> ReadWriteFile<T> for T {
+impl<M, T> ReadWriteFile<M, T> for T
+where
+    M: ThisModule,
+    T: Writer + Reader + Sync,
+{
     const FILE_OPS: FileOps<T> = {
         let operations = bindings::file_operations {
+            owner: M::OWNER.as_ptr(),
             open: Some(writer_open::<T>),
             read: Some(bindings::seq_read),
             write: Some(write::<T>),
@@ -225,13 +231,18 @@ impl<T: Writer + Reader + Sync> ReadWriteFile<T> for T {
     read(data, buf, count)
 }
 
-pub(crate) trait WriteFile<T> {
+pub(crate) trait WriteFile<M, T> {
     const FILE_OPS: FileOps<T>;
 }
 
-impl<T: Reader + Sync> WriteFile<T> for T {
+impl<M, T> WriteFile<M, T> for T
+where
+    M: ThisModule,
+    T: Reader + Sync,
+{
     const FILE_OPS: FileOps<T> = {
         let operations = bindings::file_operations {
+            owner: M::OWNER.as_ptr(),
             open: Some(write_only_open),
             write: Some(write_only_write::<T>),
             llseek: Some(bindings::noop_llseek),
@@ -278,13 +289,18 @@ extern "C" fn blob_read<T: BinaryWriter>(
 }
 
 /// Representation of [`FileOps`] for read only binary files.
-pub(crate) trait BinaryReadFile<T> {
+pub(crate) trait BinaryReadFile<M, T> {
     const FILE_OPS: FileOps<T>;
 }
 
-impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T {
+impl<M, T> BinaryReadFile<M, T> for T
+where
+    M: ThisModule,
+    T: BinaryWriter + Sync,
+{
     const FILE_OPS: FileOps<T> = {
         let operations = bindings::file_operations {
+            owner: M::OWNER.as_ptr(),
             read: Some(blob_read::<T>),
             llseek: Some(bindings::default_llseek),
             open: Some(bindings::simple_open),
@@ -333,13 +349,18 @@ extern "C" fn blob_write<T: BinaryReader>(
 }
 
 /// Representation of [`FileOps`] for write only binary files.
-pub(crate) trait BinaryWriteFile<T> {
+pub(crate) trait BinaryWriteFile<M, T> {
     const FILE_OPS: FileOps<T>;
 }
 
-impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T {
+impl<M, T> BinaryWriteFile<M, T> for T
+where
+    M: ThisModule,
+    T: BinaryReader + Sync,
+{
     const FILE_OPS: FileOps<T> = {
         let operations = bindings::file_operations {
+            owner: M::OWNER.as_ptr(),
             write: Some(blob_write::<T>),
             llseek: Some(bindings::default_llseek),
             open: Some(bindings::simple_open),
@@ -358,13 +379,18 @@ impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T {
 }
 
 /// Representation of [`FileOps`] for read/write binary files.
-pub(crate) trait BinaryReadWriteFile<T> {
+pub(crate) trait BinaryReadWriteFile<M, T> {
     const FILE_OPS: FileOps<T>;
 }
 
-impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> for T {
+impl<M, T> BinaryReadWriteFile<M, T> for T
+where
+    M: ThisModule,
+    T: BinaryWriter + BinaryReader + Sync,
+{
     const FILE_OPS: FileOps<T> = {
         let operations = bindings::file_operations {
+            owner: M::OWNER.as_ptr(),
             read: Some(blob_read::<T>),
             write: Some(blob_write::<T>),
             llseek: Some(bindings::default_llseek),
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 025e8f9d12de..85c3f93159fd 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -54,7 +54,7 @@ struct RustDebugFs {
     pdev: ARef<platform::Device>,
     // As we only hold these for drop effect (to remove the directory/files) we have a leading
     // underscore to indicate to the compiler that we don't expect to use this field directly.
-    _debugfs: Dir,
+    _debugfs: Dir<THIS_MODULE>,
     #[pin]
     _compatible: File<CString>,
     #[pin]
@@ -124,11 +124,11 @@ fn probe(
 }
 
 impl RustDebugFs {
-    fn build_counter(dir: &Dir) -> impl PinInit<File<Atomic<usize>>> + '_ {
+    fn build_counter<M: ThisModule>(dir: &Dir<M>) -> impl PinInit<File<Atomic<usize>>> + '_ {
         dir.read_write_file(c_str!("counter"), Atomic::<usize>::new(0))
     }
 
-    fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<Inner>>> + '_ {
+    fn build_inner<M: ThisModule>(dir: &Dir<M>) -> impl PinInit<File<Mutex<Inner>>> + '_ {
         dir.read_write_file(c_str!("pair"), new_mutex!(Inner { x: 3, y: 10 }))
     }
 

-- 
2.43.0

