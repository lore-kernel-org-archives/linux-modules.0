Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31B2E737B;
	Fri, 29 May 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044095; cv=none; b=Ry38LJL91SOre/r+BbAhVOJNr82jsAq6uERh8PtfXFmxshj5CrS2FWTBdtwLz+oS6/y4UnzMDKFdv5Vlbiu+88WkV48DPRPlqZUf03RUU2mGgfaOrwGG9lgKcu2+G5UJTMqRJ5PJc6wCuif/iusm0aQ9mxsqH2AQVJdsVnu0oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044095; c=relaxed/simple;
	bh=CyjlJi26II7CvKckHHnnb1gu02wSiT4bvox+oP9v56s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dFNDuFH4zPdY2e47pxIZ3Ou7LS+vjZ1eNOOqcAxaLWED2lpCVjEf1KwlwKbR5lZCj1oBE1lB4oyldZK4gSdMVaa7ZvXkNjM4WPQnTy3aXWZktWhmG8niQpWg+MLX82CVRXOjK3XPOHlE299MFI7Se5UZ8BPDH19/GBTrhszHEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnQxpiSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnQxpiSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCCE1F00893;
	Fri, 29 May 2026 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044094;
	bh=sn5+bneNN1jRhDtTMp3NKcDehOKRu+Zfgt28rAzrnzc=;
	h=From:Date:Subject:To:Cc;
	b=YnQxpiSt67Bx3i8nrSewvIQn9jiCJ2JffWGt9/Js9TgR1uxwfwjYhpJgye9N0DY+b
	 hLxVV2GK1/Gv7dPyWdOI+gClCfZbQF3U3swy/eJ+pYMSm86IEX2+nr+TrUystfRJNz
	 XeY2Ok+4zPR7HF7EoGu8KxapgilN4Iz2kLwWNUEeYaD4y9CZyhD9TKxWWyUVQEpvlS
	 L+4Sf301gWa3ErLvEkgj1AbO4f1LPgLZpdFGHvfpjdK/R/QrHO4GXUGJpQNf31LbMP
	 yAVOCfL6YyDFkIT2DwtkQhN+WESj+3lSRiQFHZouJBgniuuCKr0EObEigabXaGkLJu
	 KE70SesJ4kGpg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 29 May 2026 10:41:22 +0200
Subject: [PATCH] rust: module_param: return value by copy from `value`
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-modules-value-ref-v1-1-a0df7e9e6f2d@kernel.org>
X-B4-Tracking: v=1; b=H4sIADFRGWoC/x2MQQqAIBAAvxJ7bsEkC/tKdNBca8EslCKI/p50n
 IGZBzIlpgxD9UCiizPvsUBTVzCvJi6E7AqDFLITSmrcdncGyniZcBIm8khamd5Y3XpnoXRHkXz
 /z3F63w8+Q368YwAAAA==
X-Change-ID: 20260529-modules-value-ref-e95a7ab94fdb
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.3

For `Copy` parameter types it is more ergonomic to retrieve the
parameter value by copy than through a shared reference. Change
`ModuleParamAccess::value` to return `T` by copy when `T: Copy`,
and rename the previous reference-returning accessor to
`value_ref`. Update the in-tree caller in `rust_minimal`.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
This change was suggested during review of the rust null block series [1].

[1] https://lore.kernel.org/r/abfe2LbhLzXiGCkA@google.com
---
 rust/kernel/module_param.rs  | 15 ++++++++++++++-
 samples/rust/rust_minimal.rs |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..701210206bba 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -132,9 +132,12 @@ pub const fn new(default: T) -> Self {
     }
 
     /// Get a shared reference to the parameter value.
+    ///
+    /// Returns a reference to the value supplied at module load time, or a
+    /// reference to the default value if the parameter has not been set.
     // Note: When sysfs access to parameters are enabled, we have to pass in a
     // held lock guard here.
-    pub fn value(&self) -> &T {
+    pub fn value_ref(&self) -> &T {
         self.value.as_ref().unwrap_or(&self.default)
     }
 
@@ -146,6 +149,16 @@ pub const fn as_void_ptr(&self) -> *mut c_void {
     }
 }
 
+impl<T: Copy> ModuleParamAccess<T> {
+    /// Get a copy of the parameter value.
+    ///
+    /// Returns the value supplied at module load time, or the default value
+    /// if the parameter has not been set.
+    pub fn value(&self) -> T {
+        self.value.copy().unwrap_or(self.default)
+    }
+}
+
 #[doc(hidden)]
 /// Generate a static [`kernel_param_ops`](srctree/include/linux/moduleparam.h) struct.
 ///
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 8eb9583571d7..60d03df6cd80 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -28,7 +28,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
         pr_info!(
             "test_parameter: {}\n",
-            *module_parameters::test_parameter.value()
+            module_parameters::test_parameter.value()
         );
 
         let mut numbers = KVec::new();

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260529-modules-value-ref-e95a7ab94fdb

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


