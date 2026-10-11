Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE742E41C;
	Sun, 11 Oct 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723190; cv=none; b=NbwORY1StrJeX5PbP5DZog9MORyU4FjaTCUmiSE26pgHqTiB/o9IGrgZZyhSj0KXS9y0TKtdXn/H6nt8dVb3vF5ACDWopMZRZIrONhynq7Dm8F0mrvwI8Yxt7M/0MwmxiM5/GOalw50eubolxzedyRlHHyhsLf55UhZrF3VIva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723190; c=relaxed/simple;
	bh=tIaR0luMKd4GC6tBybMjNG+YSvI65zkRwSqDsSgV9q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Em7+LwAmeVLmPZhMHZAgDearE3aTA7EhrqY6DIEHktoTwKCFmmyHN6mZ6d9iS2hBZZiRMrYOYUQ/BbixolhwA6+m+fSY7FgM4n9UEmjhSDIJ5YPedo3K74vCvPtXBcAhraqs8Jm76jrWUL0RdHS0BoSLMbA8PQ9KLWZlqcnea2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hKvOactu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hKvOactu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723178;
	bh=tIaR0luMKd4GC6tBybMjNG+YSvI65zkRwSqDsSgV9q4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hKvOactuccNtzmpzhJrr7dfXQdHILq8JGh5/qg30RYWsmbOG3FS2aFPBShFckBvrb
	 YJB+DrKx0TPBfVss1EBdci6QHuiRO7y5DK16htIPzgKb4+YWAVO/r4pQ7eTxLzMQ1r
	 vl0b116HWOLickKMhJbXVp3fErZ2+VYIrkARY1TM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:28 +0200
Subject: [PATCH RFC 04/11] samples: rust_print: add debug messages
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-4-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=2005;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tIaR0luMKd4GC6tBybMjNG+YSvI65zkRwSqDsSgV9q4=;
 b=1lR4i6d8RZXAp8Y0/QhdFtMXWEr8F9bxOmiodu/Dkea2w+n4MTjrxrUs9in3GWxlSBxplUg6g
 FGJsBYKERMaAZdewFn6hP1h7o8AEX4MIFFHOd9FSEVdyF7ynthbbj3B
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sample prints messages for all levels, except for debug.
Add such messages.

To make sure they are actually printed, enable debug assertions.

This example will become even more useful when dynamic debug is
implemented for Rust.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 samples/rust/Makefile           | 2 ++
 samples/rust/rust_print_main.rs | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..bc27f8851571 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_SERDEV)		+= rust_driver_serdev.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
 
+RUSTFLAGS_rust_print_main.o += -Cdebug-assertions=y
+
 rust_print-y := rust_print_main.o rust_print_events.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_print_main.rs b/samples/rust/rust_print_main.rs
index 01729e87d6b5..6b9f59d7fec7 100644
--- a/samples/rust/rust_print_main.rs
+++ b/samples/rust/rust_print_main.rs
@@ -69,6 +69,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_warn!("Warning message (level 4) without args\n");
         pr_notice!("Notice message (level 5) without args\n");
         pr_info!("Info message (level 6) without args\n");
+        pr_debug!("Debug message (level 7) without args\n");
 
         pr_info!("A line that");
         pr_cont!(" is continued");
@@ -81,6 +82,7 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_warn!("{} message (level {}) with args\n", "Warning", 4);
         pr_notice!("{} message (level {}) with args\n", "Notice", 5);
         pr_info!("{} message (level {}) with args\n", "Info", 6);
+        pr_debug!("{} message (level {}) with args\n", "Debug", 7);
 
         pr_info!("A {} that", "line");
         pr_cont!(" is {}", "continued");

-- 
2.56.0

