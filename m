Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328333B42D8;
	Sun, 11 Oct 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723189; cv=none; b=Zsn2dT5yvDZmuLbrvfASPK9lQsfukME7EH/b/xUGSHYjee5R1RsaYfSLBXLhGJQEq6+q5l+ABjgMKDjfOShbxAt8wFj9nRprVKozMFbb+CKV661pGwuEaS+t4iOYlztx72dey/HAaAswTi/0DtXAxVQbSSWntR7+5AqQp6mZebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723189; c=relaxed/simple;
	bh=IqCUcdQLLWXLndFjUP+cU38OwLPS7I0T/PoPMv9nNI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WzhoPIJF9BOtIkMeK4b5vcgYVlJU6zokSqI0mjhdgsmNLwiMOEohwEzRbbwrue0WoqMpPQr9x6sby2UHkpRcRUaxkCiGM8n5FmhUJK1XeAGWAXkiVNtVbTXqkkMECNaftSrHd3h8foOqO4Ch+hin2yDpPdY+rzXHMgV880++5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ECj9kWu8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ECj9kWu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723178;
	bh=IqCUcdQLLWXLndFjUP+cU38OwLPS7I0T/PoPMv9nNI4=;
	h=From:Subject:Date:To:Cc:From;
	b=ECj9kWu8F1xrzw3c2uBsMTNOvfPUd/PCkhoCYCVMLzD/EN833xgW1h9D5hpD2eVWU
	 +TaV1818mFx2WenqDIBHQ82F0Wy8MSMdtJq+jQW+KNph+0rig2l3xRJfQZ1iNBrce0
	 b9l8DcU6y+ns4iaVsffznAkMqrvNr29B9gEhcV28=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 00/11] rust: add support for dynamic debug
Date: Sun, 11 Oct 2026 14:52:24 +0200
Message-Id: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyND3aLS4hLdlMq8lKR0XUPzJAsjozQjEwtLEyWgjoKi1LTMCrBp0Up
 Bbs5KsRDB4tKkrNTkEpA5SrW1AMpaGK50AAAA
X-Change-ID: 20260921-rust-dyndbg-17b822f24894
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=2065;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IqCUcdQLLWXLndFjUP+cU38OwLPS7I0T/PoPMv9nNI4=;
 b=LcSTC/xPdg7Dd09K6Habc7At6xUGJineOIOy7I/rsFAzbdjB7aIfukWTcugU9qQpTHjbNzJ7A
 dOz8kM/8WQfC6Xlpk/k50W+8jO1h4jL45HaF27Pge24ik0Ruz51iZnq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add the Rust infrastructure to integrate with the dynamic debug
infrastructure.

Static keys are not used for now, as the full bindings are missing
for those. A follow-up series will add that.
Also custom classes are not supported yet, but could be added on top.

Patches 1-4: Generic Rust preparation patches.
Patches 5-7: C dynamic debug preparation patches.
Patches 8: Rust Dynamic debug infrastructure.
Patches 9-11: Rust Dynamic debug enablement.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (11):
      rust: print: use CStr for __LOG_PREFIX
      rust: sync: atomic: Add Atomic<u{8,16}>
      rust: num: Add Bounded::USABLE_BITS
      samples: rust_print: add debug messages
      dyndbg: use u32 for struct _ddebug bitfields
      dyndbg: make _ddebug::flags its own field
      dyndbg: use READ_ONCE()/WRITE_ONCE() to access descriptor flags
      rust: add support for dynamic debug
      rust: print: enable dynamic debug for pr_debug!()
      rust: device: remove logging methods
      rust: device: enable dynamic debug for dev_dbg!()

 MAINTAINERS                          |   1 +
 include/linux/dynamic_debug.h        |  13 +-
 lib/dynamic_debug.c                  |  24 ++--
 rust/bindings/bindings_helper.h      |   1 +
 rust/kernel/device.rs                | 175 +++++++++++------------
 rust/kernel/dynamic_debug.rs         | 264 +++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                   |   6 +-
 rust/kernel/num/bounded.rs           |   3 +
 rust/kernel/print.rs                 |  21 +--
 rust/kernel/sync/atomic/predefine.rs |  44 ++++--
 rust/macros/module.rs                |   4 +-
 samples/rust/Makefile                |   2 +
 samples/rust/rust_print_main.rs      |   2 +
 scripts/rustdoc_test_gen.rs          |   4 +-
 14 files changed, 428 insertions(+), 136 deletions(-)
---
base-commit: 2dee3d3adcadcc57d62ba6608cd02f50b0c10264
change-id: 20260921-rust-dyndbg-17b822f24894

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

