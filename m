Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2A395AE4;
	Mon,  1 Jun 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309042; cv=none; b=CYlAHxqfRFlGy8YEMME3UpjEWwhbXogqu1mNml8l7q2Vfw38GUo7RlcG4Y1KGoA3ZDFcd867GRQW1ONvBO1F8YMxOLBNmDX0Wd48PrrQbSQu7OGQQ09P5mUtgOuVmwTuEMMR5Ius5OTHsNADzfJGko0rvGXV2eAeAqYTcRr7Ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309042; c=relaxed/simple;
	bh=oN4tgEjkssR24leQ4AFRUD6ac9mIxpWf9/nvRKN/tZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tolw3Cc4llgR2SLFtMsCsMRdxebLKZMprOj7oTCOZsGni69Sp9M3xFejFVlzpgi/dgwov4Amb1lmJmOZXoqa9LoEEoMnKLKdZNgOZjE6icBopnskMuExtgocPRPOfrQbqoZ2sAARVUhtCxDZNkmy8NkltxZLLfbfHzHyGqAE+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jyi9PvJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyi9PvJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC771F00898;
	Mon,  1 Jun 2026 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780309038;
	bh=9NOfXEJPCZhSlh+7O/rr3+37t4x5+m2fhwTPiZ2YwLY=;
	h=From:Date:Subject:To:Cc;
	b=Jyi9PvJ2wvCGGflQxF+0BEShUE3lvFDtj5BCOy5gnzIaY1cS+98uB0STdd4yhKZi0
	 7OoIT+Rpzzj3E3lmL7TMKAEqZkFAnHpvt8pmozEAN37SvXoCKeSkkwAiTjhqIjtUjD
	 l5/k7X9gW1VmnlxweiUa4QtOLfzZfvURYMOKnLXnV5b5ZEHS+cRGjiV45pyBJWfODT
	 eodVuZ1daEPQRU+HBFRYcQ0po1DlF7My9gkrkHOpPL8njmtS6AS1FbXcDPImkb3MD6
	 ujq1JTnOA8QfBUi+KTBF6Z87ggYTbPocC3gNsc3AuSyU0MQpyyLxoOEXk//jeog82H
	 EKd91Vj9FwX6A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 01 Jun 2026 12:17:05 +0200
Subject: [PATCH v2] rust: module_param: return value by copy from `value`
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
X-B4-Tracking: v=1; b=H4sIACBcHWoC/32NQQ7CIBBFr9LM2jFAbBtceQ/TBZWhJSKYwRJN0
 7uLPYDL95L//gqZ2FOGc7MCU/HZp1hBHRq4zSZOhN5WBiVUJ1ql8ZHsEihjMWEhZHJIujW9GfX
 J2RHq7lmlf+/N61B59vmV+LNfFPmz/2pFokQjrOtJU+eUvdyJI4Vj4gmGbdu+0lYoDrMAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2720; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=oN4tgEjkssR24leQ4AFRUD6ac9mIxpWf9/nvRKN/tZc=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqHVwh30q/43ydjndgORBSEwNHlxaTO04cndE/+
 WdRElx8jImJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCah1cIQAKCRD6UCkIqsW9
 0BoID/9DK/+qdBSLJO6QqtHL+SnWmp0w7Vlo6uR8WpHf2dA6jNy5GmGzlenFcY1dWpgV8XPM2tM
 i3YZsL9pXu+loqHsBv53LyKeRCvp6qvnqAVjq8MybEOQUOoASGeXZn3qRyMj9dHe8K/37aSfjD2
 gEU0BaYZsYp44DzXbEGoERyfJ1YKFo0vb2OC73OKQ1Ib8ziM8DhND1pv/P0YD6znurGbrRNtmfi
 TsjEz0uT4Hat8Rwrn/wEH2McR4R664jbAGThT6av81bMU2iY5qb/ZyG6OO7VamkVbi57Jcz39gO
 3aSthtv5wj/4uemY8oSCQkcLCZKZqvS/sKrAdPGHBif4uOLpbesvDlu+pv3w2yUDRzdNtqM0xNf
 kLvwbBadxPEyBAX3br9oSNWIYdAhHr2JFfEWLji49q465aF5ra0bEpmW6Hag6uUK5w6454IjS+/
 fGOwI6nIr5QgtDcoujXyogg2SjoqgHieDvJdvBoIj2Zeoqv1X5hgQ+N3t8T4skCVN6mixeetZzN
 6O1WglNcYhTjsReL46slcKlLrGgiGPFlvNvcPF3RQV7SgTGrc1+e/lBwS3+nk5euQhCkykapQBa
 YM48+D5RWOhLCpRX8pC9Us9UN9rYc1qkp7hwFVmlEU53jqTmJBHQooN7FNeoyzZgy44Iec9jHNx
 D0wrAJalu12Gs1Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

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
Changes in v2:
- Move `value` into existing impl block (Gary).
- Add inline attributes (Sashiko).
- Link to v1: https://msgid.link/20260529-modules-value-ref-v1-1-a0df7e9e6f2d@kernel.org
---
 rust/kernel/module_param.rs  | 18 +++++++++++++++++-
 samples/rust/rust_minimal.rs |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..a33302d1b8a3 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -131,10 +131,26 @@ pub const fn new(default: T) -> Self {
         }
     }
 
+    /// Get a copy of the parameter value.
+    ///
+    /// Returns the value supplied at module load time, or the default value
+    /// if the parameter has not been set.
+    #[inline]
+    pub fn value(&self) -> T
+    where
+        T: Copy,
+    {
+        self.value.copy().unwrap_or(self.default)
+    }
+
     /// Get a shared reference to the parameter value.
+    ///
+    /// Returns a reference to the value supplied at module load time, or a
+    /// reference to the default value if the parameter has not been set.
     // Note: When sysfs access to parameters are enabled, we have to pass in a
     // held lock guard here.
-    pub fn value(&self) -> &T {
+    #[inline]
+    pub fn value_ref(&self) -> &T {
         self.value.as_ref().unwrap_or(&self.default)
     }
 
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


