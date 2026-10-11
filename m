Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFE4519A0;
	Sun, 11 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723194; cv=none; b=phKdfUfpO+GG7VH0F4o9EA0Lcnu5P3P2c2eK63OekOWM0kp2ON/nCfsEfdYU4JinRx0SgKDmW4zTE5lw4LbG3mt2BoSjLWnuy7PfolyTVbX7jAdx02NGwSZHCxj1HxYPrTM59pIHn8EUTNBrnGYNET8RdnH4wEJHDFZZ17tGJk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723194; c=relaxed/simple;
	bh=zvbL2EcvgHpJz1xdEJKBZOx40vnf9+yo58HV2ydg0NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfLB6P7YZoduERIBoawQMY3v3VMCwq/SYup+u8CaKbDJyk3eHHbuQoR8F6azDLg6x4F/hYgmLsXYWMgs9s7YGJjHnxZxRgUwFXtyP5lUSr7pKOdp3RSkTXY17guNaX+/bYTTHBHZmEQxBZK3eu4JVEWCdLg7ATWJMNmtdObpZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hkki6SlI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hkki6SlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=zvbL2EcvgHpJz1xdEJKBZOx40vnf9+yo58HV2ydg0NQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hkki6SlIs7pRZ2Cv4WQbH2DxeeVJ2Xbk404XEnji6ik+vQi3NY2INobSdyGC9+qde
	 6+zbpMaTuQb2qN/4n2dIePsBHz4DInqRP8ydjdkxTDfVp6EWfih9KgqksS01yzadfG
	 nb43ySslNo0DnJyWJO54cdzwNq4jt14gw6iG7B5s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:29 +0200
Subject: [PATCH RFC 05/11] dyndbg: use u32 for struct _ddebug bitfields
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-5-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=1244;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zvbL2EcvgHpJz1xdEJKBZOx40vnf9+yo58HV2ydg0NQ=;
 b=BTU9vCzDKby/EWmUhoYtOavPtFoQotoBgriteMKV616f1yNLdBzlSAioBLY/dFFPJDt/B1wcr
 9UppXUZz9Q6ALJEMJ+MhnwS3BX3jwGPfCvI3Zw7A/SlYfQeqOxy8lOV
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make it more obvious that the bitfield is 32 bits wide.
This will be especially useful as the next commit will change the
bitfield.

No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/dynamic_debug.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 05743900a116..0b34343df594 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -7,6 +7,7 @@
 #endif
 
 #include <linux/build_bug.h>
+#include <linux/types.h>
 
 /*
  * An instance of this structure is created in a special
@@ -22,9 +23,9 @@ struct _ddebug {
 	const char *function;
 	const char *filename;
 	const char *format;
-	unsigned int lineno:18;
+	u32 lineno:18;
 #define CLS_BITS 6
-	unsigned int class_id:CLS_BITS;
+	u32 class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
 	/*
 	 * The flags field controls the behaviour at the callsite.
@@ -50,7 +51,7 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	u32 flags:8;
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;

-- 
2.56.0

