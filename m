Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA594519A3;
	Sun, 11 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723194; cv=none; b=gmBgTqpepOdFaoP0QoEoXHQnFi33BEJ+B0DnfMQpUmgW/v4PRoR+O5UJ91Z8nxq1MERMadyrpA3Z0IFecotFFcOZvm1ySVZSSAJDtsPrrGqNpOE4+6WnKntokZd2AQ4FbyxwzPTHKlqwyYF8s0LxPUjk9MSNKeRMU8P+dixcWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723194; c=relaxed/simple;
	bh=dq0pzoaneyPYdJB9Xd4qz1kLSari6Q/DmExFQSWUTjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkNF6Zfnbw1qSm56RTCTy4QDB5htjf2zyTbvm+voFHZn7ADYM3K/ZfteMYX97+Y4e70OBpInc3VuHJn0ubWb6C9zZwm3gvPpoJroY8Lw1Gv3DexdcbfEVXVXn/8BXbUb4PWY0JCs5neOfSbFVSjxw9ZOBt1uYb3eGp61BgSzq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VoiiGhc2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VoiiGhc2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=dq0pzoaneyPYdJB9Xd4qz1kLSari6Q/DmExFQSWUTjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VoiiGhc2tbrROVv/b9ogb4J44sjz88u9Qh4xnNG05xXHdt+bf7xDXKA/aBP02Gqba
	 ci44qDPOCbcDSWUbOF6TmebTbQFa/m5wm3H9zbft1wz2aydVH8vDbWfFmB1Tf7mOnW
	 RIzK179lOsHXPsWkPoYPYbQQis9jsia8vxj3AqRo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:30 +0200
Subject: [PATCH RFC 06/11] dyndbg: make _ddebug::flags its own field
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-6-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=830;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dq0pzoaneyPYdJB9Xd4qz1kLSari6Q/DmExFQSWUTjM=;
 b=rIx5rlqLZKBf2uIPqjUjmO+qKAXAwCqj8XUWWL+Llm9hgVc+4CF4OagRShQSanf5Et8dMO0QR
 NvoQ24PtetHA1ROoD43n7qQ4ydx30sTNfB+C5A+T+2t0MjpQTz3Guh/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Keeping the flags as part of the bitfield prevents the usage of
READ_ONCE()/WRITE_ONCE() with it. It also makes access from Rust
awkward.

Make it a dedicated field.

The new field will stay in the exact same location in the parent
structure.

No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0b34343df594..b1ff7c0e9a5f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -51,7 +51,7 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	u32 flags:8;
+	u8 flags;
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;

-- 
2.56.0

