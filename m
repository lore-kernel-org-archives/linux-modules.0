Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93D382297;
	Mon, 23 Mar 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270117; cv=none; b=bByTggPVQaUBXU52BPdVlrnnjD86hYpGJ5PCBPoUYZzz7TpxRDaZD9ZuFyM+p4WIoNREZ/EjMwSht2FgaLWilypItLz5l4PlXZLkOr052mOTzC4l3ZDc0MDyLPVRgZAZf204y3CfYpAlCQ07RrJLrIsaH7mj8qD0lG4Tg4rWx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270117; c=relaxed/simple;
	bh=NH04tbhY13Lrlqx874OPUd7KS2vl12I5bTlzcU2/oJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uR9yLibRJIa3gUTJmPSts6U3OZKvigPb5z5hj/bggAvqcIA0M2qxbn3cxQIrNddwfKCBiwJ3F7U6Xae/xpPdIeOlhbMp/B7zAm+Tv6eNyKEyqRI4iUZn+Z8togqqabbYHPDMwCa94rey8fxxwBQAEBxApZTEO/ueYepbSQtHf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khZd0Ktj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khZd0Ktj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45721C4CEF7;
	Mon, 23 Mar 2026 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270116;
	bh=NH04tbhY13Lrlqx874OPUd7KS2vl12I5bTlzcU2/oJo=;
	h=From:Date:Subject:To:Cc:From;
	b=khZd0KtjEQ5ZIJjyQFnGLApXOrBUjkH+iSeTynaGVi3/g41Re25Ojlc8D9SW/krGS
	 od4xzbh1rLSRgH0yrtHxe8czZgdqpOGVRLRBLqbBhGGFu5V2St5ZSgDlbXjGzYqbHY
	 0BzytaX0W4YmLl9gRdxh7WCmQO34ekVWQDLTBbDrVwaVQII28YSaA6bOpHMEMO/j/c
	 wv4xAj1QXIYHrLsbUNAevlDqZAdx0fM0jdL6LwfOd18sQQ8JtrFM4Bmfkrq8UJyUDv
	 qURa/LI5QGWuS5n+zumBnW0t9sQmwsordrpwlLGzn8bf4/CSdPu0dC28Jo597OWrjD
	 3lZVfLqJI13RQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 23 Mar 2026 13:47:12 +0100
Subject: [PATCH] rust: module_param: return copy from value() for Copy
 types
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-module-value-ref-v1-1-32507e1085f1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE82wWkC/x2MQQqAIBAAvxJ7bsEsQ/pKdLDaasE0lCKI/t7Sc
 QZmHsiUmDJ0xQOJLs4cg0BVFjBtLqyEPAuDVrpVta5xj/PpCS/nT8JECxprm9E4akftQLJDJN/
 /sh/e9wPMllPHYgAAAA==
X-Change-ID: 20260323-module-value-ref-5884b5ae6b2a
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=NH04tbhY13Lrlqx874OPUd7KS2vl12I5bTlzcU2/oJo=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpwTZQJe38c0N8srN7yP7r8zhkhUKIQ+AKgdSug
 L2HwHu0kz+JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCacE2UAAKCRDhuBo+eShj
 d7OQD/9YJw/Sy3e1/2oOd1WEoJx5wyy9uIhQDuFrxDeT4ou7AssYlgPKaYmikFwQc74rVMLxzVj
 mIvNW9dOvmWqqGOofi3W4Qf532JEmCORuMMuKqCi5NU+FKN5Qh6E8Fpn2WSVJ0wUZ/FQ8j9G8OG
 8deXe58OBw3/f2imiJ2KLFGITOumuc7bb18QDnIo+jrk10ir6Rx9jnjG6W2d9CckzAjcfayO4wi
 i7X8HqKyP9iE8Wlsx2HAVEnv6McCbvbA3qzubUgyfqoNyZkE467yFM8d8h+JYTneLY86Y/cbah9
 7YicEnLwRAxELVg/lORv2+Vzxa6jH0lbeAWFjTgy2zPSuvYW+PVUcOVA5uS4PdI0PeESiG0ysxJ
 Pj05Z35gYlbutFtTxJQ4AQ9K/NyYZe3zy7iYJqVd8Ju8TNj8Q1EL5u/Oi9w1vWqwPmu2aq7op8I
 rjQXBzYXsiQDbNlyyy25cnWnDQ72cJU85B1rKkBx2FP6jKDjNWg+U5ifxqMs+LJJLdGi1vvLQV6
 05EqplAUqbXz4Ny69UM1pNfyGp9Bpx28lQ9YcgUpSQnYzW9AYC6ahGni+45tpl3v7nXUwF0guST
 dziLwSi5bNtWiRDApaB7Iw4FH1SSbLcW0WMCeNwtudYYd3zDVm7r0Q5K1uDvRfK3fG81FWSHGzM
 b7BSHwZ+SGlEPCA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Rename the existing `value()` method to `value_ref()` which returns a
shared reference to the parameter value, and add a new `value()`
method on `ModuleParamAccess<T>` where `T: Copy` that returns the
value by copy.

This provides a more ergonomic API for the common case where the
parameter type implements `Copy`, avoiding the need to explicitly
dereference the return value at call sites.

Currently `value_ref()` has no in-tree callers, but it will be needed
when support for non-`Copy` parameter types such as arrays and
strings is added.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
This change was suggested at [1].

Link: https://lore.kernel.org/r/87cy13swpw.fsf@t14s.mail-host-address-is-not-set [1]
---
 rust/kernel/module_param.rs  | 11 ++++++++++-
 samples/rust/rust_minimal.rs |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..5dcfe2ba87a1 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -134,7 +134,7 @@ pub const fn new(default: T) -> Self {
     /// Get a shared reference to the parameter value.
     // Note: When sysfs access to parameters are enabled, we have to pass in a
     // held lock guard here.
-    pub fn value(&self) -> &T {
+    pub fn value_ref(&self) -> &T {
         self.value.as_ref().unwrap_or(&self.default)
     }
 
@@ -146,6 +146,15 @@ pub const fn as_void_ptr(&self) -> *mut c_void {
     }
 }
 
+impl<T: Copy> ModuleParamAccess<T> {
+    /// Get a copy of the parameter value.
+    // Note: When sysfs access to parameters are enabled, we have to pass in a
+    // held lock guard here.
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
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260323-module-value-ref-5884b5ae6b2a

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


