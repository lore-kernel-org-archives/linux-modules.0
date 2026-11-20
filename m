Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192349;
	b=Xih52IIMaV++VisoUXBbXQYZVqAYLWJRirN/H1myaj2G1rcLCOKVRJee2aRk9PGcquWl
	 WJUBKrYmreDN2ZPdiMh4V1nSpt+rB126MT6mWyZp18kCVGVR6Il8vYvuia84y1teFDCBD
	 N4vSe3oZwd6w7+8U06RX9v8QaXd7JLBwwOKc8ewsM13wEMJq7Vk95LsNkNJDOjd80RxSa
	 8H6m808AhhHQSYlEbvDQrTcNMD1+HsfjCrk8IaeD+Vg+9n9VZKYqqW8CzD4mgEgxsVvtW
	 42MycBrPI4w2wbNSnHrJ6DdzGUbfXWmYuogR3fFsJYzSBk/tdls6hOB0MdSl+XvdxXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192349;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xFXT3t1CiYZhcwKGWduI7MEsRw+SOFCG4fBp9+M6zRk=;
	b=N80kkLfdGPY12Owc7eYaNJztu2mEF0iRFgpQr34bbCKu9HbLDVvTeaE96f4oT5iBaEed
	 eadwL0BgujzKjBD8+BgmsDFSz2NSNHbTbFqk4kA7mBKubMYzVXdtcDBSWsCl/UARovHDd
	 5XFmUX0S3cAUmgqwZY/dzt+RIKqtjDY5mEz0K8AaWxNSUZr9MLKDdEWgonmTyOVsNWRAB
	 /PDoq9PxC6kgzFIg2aqrvEmIAS6l7kKDGcHOFgCHUy8uZHYGLKq+fkiF32o2eQFMfzlpw
	 GSJ4lroDUBP+iPkTflYL0+3hdzeMQYuSQubcPypYoFRFKjS/Cguaxdl1d8JRZITugDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDzsQyRJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EB606A331;
	Fri, 20 Nov 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDzsQyRJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795192348;
	b=bbbrNx2lxXvL3lqiTXNFOOvd5L5OWuoPdkFty4r4QWfeuE2O32tpF2ISjkaqIFxHkvua
	 p0krKt/EKnN+W0k528v76I4gp8GKOUAAekdU2Zai8wqWzjw1QUelmIfRvxfpjNbUyp8nQ
	 DDsEvbJPoAObNP32CqDp9twOCdJvMe6n/zafADWIpYy7XAthSHAKZ2NZ5gmC171DAIKL9
	 2E7CA32tN95MEcLe3JbHYmiWFTx7mWxnDZMmllGt3bGKb6Pomo3V2MTOjhijppFpu5CDI
	 aU1uejvK5bdP+yXYM4F53anPHLMz3lVuvrsizAp0n2DS6Wkyss6MiWchLiG2rqKaWHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192348;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xFXT3t1CiYZhcwKGWduI7MEsRw+SOFCG4fBp9+M6zRk=;
	b=GfpWxJAequCRvXM1DsOqb5A0Pm0iVt3fxPWMM6snoOuoHe+EtYJydCOrI4N5t1ssoOWV
	 Hbb5mhXNeNVjrg66fT+QUxfyJO5Em3TKm0tRCEwUVuxDay+Ik9fw68bayjHI8YJgYkiLw
	 MfuBGvdfsS2gZ9e2xRfq1Ntq+6WLZfA7UHDKB1rdfwnaXS2TsX4u4iPsA+1fRyoMiX03O
	 OLNdm6AUxpYg55c/cccRg1IAdnBfSdfMdrizMOR0lcR6HWIOmDqq4d6K1rhZtcUpzJtgb
	 H8UPBYZepWTreILpYDu51e9ckV7AWcfSgaKFY2rnrr2gpH1T0pM4omnVvWoqnZDSr0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B8CEA1F000C6;
	Fri, 20 Nov 2026 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795192348;
	bh=xFXT3t1CiYZhcwKGWduI7MEsRw+SOFCG4fBp9+M6zRk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=XDzsQyRJNzR7qXzq9YFHZZgsaqfXAouys19tTsE8wGKzpFxipIBeG2L5YZU/QZGkO
	 FnhEdiKnEL/0NCb0EyYCGc+SL6YG7Hrs8PECK7nTaNoDYTTBdKLZYWANmIp+50SO8R
	 oJtsV2d/wdcOEgE/LllIRS4R2LUdf8wGzjQjd3ElI8EdSWWAk0NHYaC9FmgOKCjYfA
	 ykuFnnfUW3WE+LAW9hkLMLGTqB+Q8NP2H3RAUzZUPjyFp4O7uF4zQyeAY4WrJdLW7K
	 f+c4kUSx5SkQoozJyjVsXP48G17FUq0eFtZxP+AUSCk2+DI8porAJf/DX7agK1uibk
	 1KK1y2ijuQkTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 347B64994E;
	Fri, 20 Nov 2026 16:32:20 +0000 (UTC)
From: Peder Bergan via B4 Relay <devnull+peder.bergan.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 17:32:12 +0100
Subject: [PATCH] rust: put C helper exports in a dedicated namespace
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-rust-helper-namespace-v1-1-3b9a05553ff6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAt2AGsC/yWM0Q6CMBAEf4Xcs420RjH+ivHhKIvUSG3uiiEh/
 LsUH2ezMwspJEDpVi0k+AYNn7iBPVTkB45PmNBtTK52F2tdbWTSbAa8E8REHqGJPcy5wdWfGqD
 petrcJOjDvHfvjz/r1L7gc4mVR8sK0wpHP5RpSpoFPB73fsScaV1/Kuql2p4AAAA=
X-Change-ID: 20261120-rust-helper-namespace-57e8c37ee7df
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 Wedson Almeida Filho <wedsonaf@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795192339; l=3698;
 i=peder.bergan@gmail.com; s=kernel-contributions;
 h=from:subject:message-id;
 bh=5abfNuTCOBRWevTCg/nJxA+AusAhHZG6K5llcZxRyjI=;
 b=kHhyiIoVhUVvEZ39eIExpOF7QUtA1sz03mr1zCe+6+mUbacftH2am3hofEnCEBIkZ6Y7elFJw
 1dEuwYZ8hHfADPm4c37j0mG/eJgltFQ5TJZ0LLUmtyK2jVAim1/mjBu
X-Developer-Key: i=peder.bergan@gmail.com; a=ed25519;
 pk=39790pn1YZCulHBoUG1uiQI1Hm01EvhBEa2zVrS/yN0=
X-Endpoint-Received: by B4 Relay for
 peder.bergan@gmail.com/kernel-contributions with auth_id=1395
X-Original-From: Peder Bergan <peder.bergan@gmail.com>
Reply-To: peder.bergan@gmail.com
Content-Transfer-Encoding: 7bit

From: Peder Bergan <peder.bergan@gmail.com>

The rust_helper_ prefix marks these C wrappers as Rust implementation
details. Their exports use the default namespace, so GPL-compatible
modules can link against them without an explicit import.

Export the wrappers in RUST_HELPERS so modpost can detect accidental
dependencies at build time by flagging a missing namespace import.
Have module! supply the import when the helpers are exported, since
inlining and generic instantiation can introduce calls through ordinary
Rust abstractions.

External modules that call these helpers without module! need to
declare the import explicitly.

Suggested-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/216
Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
---
The two Rust sample modules loaded and unloaded under x86-64 QEMU
with namespace enforcement enabled. Removing the import made modpost
reject the sample. The exports and imports were also checked with helper
inlining enabled and disabled.

OpenAI Codex assisted with coding and testing.
---
 rust/Makefile         | 4 +++-
 rust/exports.c        | 2 ++
 rust/macros/module.rs | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 0165626decbe7..17c559052e936 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -569,9 +569,10 @@ $(obj)/helpers/helpers.bc $(obj)/helpers/helpers_module.bc: $(src)/helpers/helpe
 
 rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__(pfx|cfi|odr_asan)/ { printf $(2),$$3 }'
 
+rust_export_macro = EXPORT_SYMBOL_RUST_GPL
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n") > $@
+	$(call rust_exports,$<,"$(rust_export_macro)(%s);\n") > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
@@ -585,6 +586,7 @@ $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 # function either. Therefore, we export all symbols from helpers and bindings.
 # In the future, this may be revisited to reduce the number of exports after
 # the compiler is informed about the places codegen is required.
+$(obj)/exports_helpers_generated.h: private rust_export_macro = EXPORT_SYMBOL_RUST_HELPER_GPL
 $(obj)/exports_helpers_generated.h: $(obj)/helpers/helpers.o FORCE
 	$(call if_changed,exports)
 
diff --git a/rust/exports.c b/rust/exports.c
index 1b52460b0f4ee..fde2a52d2a1ae 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -14,6 +14,8 @@
 #include <linux/export.h>
 
 #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_RUST_HELPER_GPL(sym) \
+	extern int sym; EXPORT_SYMBOL_NS_GPL(sym, "RUST_HELPERS")
 
 #include "exports_core_generated.h"
 #include "exports_bindings_generated.h"
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 0a7b9e24c9600..ac3376fa8fb85 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -467,6 +467,11 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         }
     }
 
+    // Inlined kernel code can introduce calls to C helpers in any Rust module.
+    if !cfg!(CONFIG_RUST_INLINE_HELPERS) {
+        modinfo.emit_only_loadable("import_ns", "RUST_HELPERS", false);
+    }
+
     // Built-in modules also export the `file` modinfo string.
     let file =
         std::env::var("RUST_MODFILE").expect("Unable to fetch RUST_MODFILE environmental variable");

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261120-rust-helper-namespace-57e8c37ee7df

Best regards,
--  
Peder Bergan <peder.bergan@gmail.com>


