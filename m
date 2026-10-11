Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4444F56A;
	Sun, 11 Oct 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723194; cv=none; b=T2OJ4w0tfhJQO0dvQC0vMmeefDH5Nlil8QEJCrgs4r5pVPT9GCCCxQ2D1+5TiACwrft1hD/Bt1yib3S1Oda4BZiEUXWvPAuY4i59vKlJOquoaJt5thnn/HjmrR5DWgVT+FbYvE8JDNmtY+cF+opmAUWaVV7hUZTkYtgkNzUiWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723194; c=relaxed/simple;
	bh=0X6E8XbcoOuMWft5lPU/aoVPZzU+7VaqeA22p9C0ivc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/FID9mHQmDqmxbR4tlMKWc8TyrcLuwxkkMiKxl5VAMlgEDyzFr9kdpZspDWCbNibbyy6Q5jVeVh8EqPRpP4N8mN6/iJICqYTGxdNYdPpbYnKMw6jL9ejkAH5ySJntqId6bo1GiLL5LkAzzI9qlYADojtAn7RNywqcegoSO1t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KZ0B8tVe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KZ0B8tVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=0X6E8XbcoOuMWft5lPU/aoVPZzU+7VaqeA22p9C0ivc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KZ0B8tVe5nRaNoscBVKhSixpsrR/GFM9rbqQMgGrvjnpxQ0PF7EBOemCP1yZ7rq5Y
	 SywkaQ6HpZ/l1Ox/9WwT8h7U3OMcV+Ste1XKeQa6beGEyCOAYp1vzM3uzvUC3+5NJw
	 FlakBqidpbBc42i7avRuLd49zs28mzjCdxbor+z0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:35 +0200
Subject: [PATCH RFC 11/11] rust: device: enable dynamic debug for
 dev_dbg!()
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-11-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=1810;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0X6E8XbcoOuMWft5lPU/aoVPZzU+7VaqeA22p9C0ivc=;
 b=OUiFdtITI7Ghw4pQ9yWnt9E/xwQl0f2NIw3aLP7PqcCG62vQBU6RIPAb0iHmSKO4Ub5Xu41rt
 ywMaTT4pPzlBqUfknKMY5ExGrV+AD/58/4v+NA9DnnuKHuG2Buh/spJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Wire up dynamic debug to also work for the dev_dbg!() macro.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/device.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2d49063f4f7c..db2c9adc5410 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -896,7 +896,7 @@ macro_rules! dev_info {
 ///
 /// This level should be used for debug messages.
 ///
-/// Equivalent to the kernel's `dev_dbg` macro, except that it doesn't support dynamic debug yet.
+/// Equivalent to the kernel's `dev_dbg` macro.
 ///
 /// Mimics the interface of [`std::print!`]. More information about the syntax is available from
 /// [`core::fmt`] and [`std::format!`].
@@ -918,6 +918,15 @@ macro_rules! dev_dbg {
     ($dev:expr, $($f:tt)*) => {
         match (&$dev, $crate::prelude::fmt!($($f)*)) {
             (dev, args) => {
+                // TODO: Switch to cfg_select!() when that is usable.
+                #[cfg(any(CONFIG_DYNAMIC_DEBUG, all(CONFIG_DYNAMIC_DEBUG_CORE, debug_assertions)))]
+                $crate::dynamic_func_call!($crate::__format_string!($($f)*), || {
+                    // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
+                    unsafe { $crate::dev_printk!($crate::bindings::KERN_DEBUG, dev, args) }
+                });
+
+                #[cfg(not(any(CONFIG_DYNAMIC_DEBUG,
+                          all(CONFIG_DYNAMIC_DEBUG_CORE, debug_assertions))))]
                 if cfg!(debug_assertions) {
                     // SAFETY: `klevel` is null-terminated, uses one of the kernel constants.
                     unsafe { $crate::dev_printk!($crate::bindings::KERN_DEBUG, dev, args) }

-- 
2.56.0

