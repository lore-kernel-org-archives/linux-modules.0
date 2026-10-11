Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FC44F56E;
	Sun, 11 Oct 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723193; cv=none; b=RPSLOIvlV0BFYUUTjrFnNuKpNJY04/IZGjV29XwrKACdE5o4a9N961f8pkYldtcv4errzpdFOA6QFEKRROZvk/eOfYxS0gUrL4y+gtrukuVjXzsU4fc/ehZSSaezkNLIb6zDYpVHGAQUx9aTIhViupKbfvaNadG2qbhXmnqaok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723193; c=relaxed/simple;
	bh=zCkov56KbxkpOiGipAuJwP5w7fooVBJXfw49HxSQmLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiLwLdosUbEyTjTFbtkeM8T998mX1SD/GIAfNYAoBrIR2QORMsRmqU5RgwcMkko+JVwZ4pxI2FDUrsiypWizq9EtTpi361hKEc7UJJsGLHVpbdumV+2hdG/YQz6pLmZxrHkEMhDdKXTCIRSqfd4s45fIojpWHg+skRjT5ReSkoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CYogGsnp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CYogGsnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=zCkov56KbxkpOiGipAuJwP5w7fooVBJXfw49HxSQmLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CYogGsnpBWKyN9IV/fEJK9J6KMnw4+tTIWmyGCrSRS0zRBqorVMCElHgobdIugpJ4
	 mrMD7QvMXfco37TtRaZQ4PXWUcpRHR1R9k+u/xhLd//yd0A/4Q94Rrnu7Pf+kjpJMi
	 rqY8c3XboDOm6j2eX3xXhjfpCBdLwhH4sSj67+7c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:33 +0200
Subject: [PATCH RFC 09/11] rust: print: enable dynamic debug for
 pr_debug!()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-9-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=1489;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zCkov56KbxkpOiGipAuJwP5w7fooVBJXfw49HxSQmLs=;
 b=aFwqjhfQ9KZj/Z3uXuluKkkof5qcP9HlvkDvSAMUl+B9GL34+Rx5ZeiKYLdq+dHAVZOY4ObTx
 L37uPxFjN7HB30pPEFDH0TdBcpbiFZ182bdmSLyneemEoPYiYNKKjbH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Wire up dynamic debug to work for the pr_debug!() macro.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/print.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 9ce52b9fa69f..9a0870c2df94 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -373,8 +373,7 @@ macro_rules! pr_info (
 ///
 /// Use this level for debug messages.
 ///
-/// Equivalent to the kernel's [`pr_debug`] macro, except that it doesn't support dynamic debug
-/// yet.
+/// Equivalent to the kernel's [`pr_debug`] macro.
 ///
 /// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
 /// [`std::format!`] for information about the formatting syntax.
@@ -392,6 +391,13 @@ macro_rules! pr_info (
 #[doc(alias = "print")]
 macro_rules! pr_debug (
     ($($arg:tt)*) => (
+        // TODO: Switch to cfg_select!() when that is usable.
+        #[cfg(any(CONFIG_DYNAMIC_DEBUG, all(CONFIG_DYNAMIC_DEBUG_CORE, debug_assertions)))]
+        $crate::dynamic_func_call!($crate::__format_string!($($arg)+), || {
+            $crate::print_macro!($crate::print::format_strings::DEBUG, false, $($arg)*)
+        });
+
+        #[cfg(not(any(CONFIG_DYNAMIC_DEBUG, all(CONFIG_DYNAMIC_DEBUG_CORE, debug_assertions))))]
         if cfg!(debug_assertions) {
             $crate::print_macro!($crate::print::format_strings::DEBUG, false, $($arg)*)
         }

-- 
2.56.0

