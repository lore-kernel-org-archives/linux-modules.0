Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658434519A6;
	Sun, 11 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723194; cv=none; b=OM6/uLwXbpYU6pMrbJ0vBM5q5xVWxAKGT8iwj9SOO7qSsjxXwyB6NsrxvaOXYLDGXUc9/K7dFj8ncnI7zaL9tmXaF+bNmB3VJcLJ1p1DbBlYT6k/clK5freAWD5N9Caqo8AepmestgPOnjkKSL2BNQ0f3My9XsV8t3NY33jk57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723194; c=relaxed/simple;
	bh=RR7zMPiGuPjfJFZCpgSBqoVbazkLegLYzzzb2EcrmL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7aVB8Bn+MrxxnFYzUSLtJ3nvA22m5NPZDNMcV2WdTUDyUOiXd3DVOKt5by3u+4JU+zZ4pyaECpyVyFb32/C5smGTzcEBUTH7k1cpZltQGn1tvegaHjjaZh8N1a0n4EhA9v3Np686dCakc1pM3qAKDIytCmh3038JCtmbSRkvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UAi6iHLK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UAi6iHLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791723179;
	bh=RR7zMPiGuPjfJFZCpgSBqoVbazkLegLYzzzb2EcrmL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UAi6iHLKK9MjdXMOLx7IjPDRwop9K8fGkHISnKWJJyKCoKvtxYNfk5ieOVgCqwt7i
	 ByFJ3+FbZqT+oe2VsSB/NoHTvpSugLAh8+cveO9uHvi5j/KdF4pg2XVhVsIMwyNigq
	 kFAZrdvcm7+QioTRRQdWA887g0GzhFcoRI3xRxWc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 11 Oct 2026 14:52:31 +0200
Subject: [PATCH RFC 07/11] dyndbg: use READ_ONCE()/WRITE_ONCE() to access
 descriptor flags
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261011-rust-dyndbg-v1-7-832e4039b71f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791723177; l=4487;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RR7zMPiGuPjfJFZCpgSBqoVbazkLegLYzzzb2EcrmL8=;
 b=hkWae9yy88C7wCNszAppZS3HB+EBQV13eD4zIyGN5KCWhUghxv03BuRPpVT2n/+CoTfyKWiQv
 5PMjxucl4h0DK47r2PeDb3gBXX7LWkNJjSopAB3vJl2Jl0ZVK2F+C+8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The descriptor flags are accessed concurrently. Use
READ_ONCE()/WRITE_ONCE() to keep their contents consistent.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
I am not entirely sure about this. We are only using single bits, so
torn reads/writes should not matter. But LKMM has no guidance on this as
far as I can see. Also for Rust this seems to be necessary.
---
 include/linux/dynamic_debug.h |  6 +++---
 lib/dynamic_debug.c           | 24 +++++++++++++-----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b1ff7c0e9a5f..6986142928ef 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -164,7 +164,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define __dynamic_dump_stack(desc)				\
 {								\
-	if (desc.flags & _DPRINTK_FLAGS_INCL_STACK)		\
+	if (READ_ONCE(desc.flags) & _DPRINTK_FLAGS_INCL_STACK)	\
 		dump_stack();					\
 }
 
@@ -207,10 +207,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(READ_ONCE(descriptor.flags) & _DPRINTK_FLAGS_PRINT)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(READ_ONCE(descriptor.flags) & _DPRINTK_FLAGS_PRINT)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 18a71a9108d3..6dfd125fa6be 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -244,7 +244,7 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
+			newflags = (READ_ONCE(dp->flags) & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
@@ -260,7 +260,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
-			dp->flags = newflags;
+			WRITE_ONCE(dp->flags, newflags);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -822,12 +822,12 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *desc, u8 flags, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -835,16 +835,16 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
+	if (flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				trim_prefix(desc->filename));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
 	if (pos - pos_after_tid)
@@ -857,8 +857,10 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 
 static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
-		return __dynamic_emit_prefix(desc, buf);
+	u8 flags = READ_ONCE(desc->flags);
+
+	if (unlikely(flags & _DPRINTK_FLAGS_INCL_ANY))
+		return __dynamic_emit_prefix(desc, flags, buf);
 	return buf;
 }
 
@@ -1146,7 +1148,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp->flags, &flags));
+		   ddebug_describe_flags(READ_ONCE(dp->flags), &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_putc(m, '"');
 

-- 
2.56.0

