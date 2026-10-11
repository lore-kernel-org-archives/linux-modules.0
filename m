Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDB3E4C61;
	Sun, 11 Oct 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723190; cv=none; b=suIqmoj7sEoJMkNISX+IoRLGnBpOqCVF19TqQCE7VAGrSfqWL8Y8Y8xM4LkOiL+Jwt62EdL9QQVgwXbQg5HASt+ifxKKFxcrwdbeKQAGsrgGMCfENGfmz3wIZw3Ez4nPB04GRdBjkW5pX4x9/HN2DEMXPnbHn98Wu6+yvU9Bbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723190; c=relaxed/simple;
	bh=WSTXMpKTnLiyqMRDokJXGtKuo0B0jnD5Q65tR1e+V6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIDpznNPz7CQU66WH0Ph3FXnQp7PmxLyvQtsjHdcI2+m5C5aqHdBOK4yXjuEd0wW1uIAtNA5Jk5PdrolZeOINhyXPsJOfy8jELlfgwfWz31mrdzXyt5p1FGbIDYx/uH/82j0d5eYDwqp7YDp/wfnvMT/zJ9nLSSVLO+fl2KlIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KMP2gZSM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KMP2gZSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723178;
	bh=WSTXMpKTnLiyqMRDokJXGtKuo0B0jnD5Q65tR1e+V6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KMP2gZSMmpXKbBI0rBNTYKzzFFMyh1kDQ82OQKIoWFx1b4P6TgA9Gb3XqnbF+Q86F
	 0hWouWzs+4jomaZGWu29OR4JmaSgsQ4Z4pd9M+tpTnP+xVhcVvgojNnTUVPwc/My2R
	 VSDJLDwEVWsA3a+uaOPJBboSNQPCeAcmShMTYp8w=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:27 +0200
Subject: [PATCH RFC 03/11] rust: num: Add Bounded::USABLE_BITS
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-3-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=871;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WSTXMpKTnLiyqMRDokJXGtKuo0B0jnD5Q65tR1e+V6M=;
 b=7k9xrsol+/BTKb5N6r7vwfMTc8FaOc4tYqqBitDEyVIa9nGZeMAcG6M+Qkr8Z2zVZaU/TEyWu
 qoIU7NvyMU9AkG+KjC1H4EyLhCq36A7slpnohk4CZgUh/eUZMAsF+B7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Expose the types usable bits as an associated constant.

This can be used for example with static_assert!() to validate
the Bounded type against bindings constants it reflects.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/num/bounded.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 2a2b0a4bca5e..4045e5aeb7dc 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -285,6 +285,9 @@ impl<T, const N: u32> Bounded<T, N>
 where
     T: Integer,
 {
+    /// Number of usable bits in this [`Bounded`] type.
+    pub const USABLE_BITS: u32 = N;
+
     /// Private constructor enforcing the type invariants.
     ///
     /// All instances of [`Bounded`] must be created through this method as it enforces most of the

-- 
2.56.0

