Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5733CE91
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149672; cv=none; b=OGWpCatbuMY5+m56uWfSTObvk1xtwg7RCPeahuMPcwOxcAadCt2/v49dqJ5oZmH0W5yf83Qdn8aORulb1MI7KnUiXCjwe7PN92/2eZ+rx0IiPKbF0TU2fmwEe6Ycv9zZTUb88xwdIdCSk/0cu2HAgym7JAtq3+0mShOqCMubjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149672; c=relaxed/simple;
	bh=eHSd6gZAgAs99aURB/P61YrQaeqSUqKmTJDHpVJAJgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spmgjRHD1nxZHD9T9BWtRC1LKOth+YU6wy45Ce+X2CwsnfogrTbCwkoxNBc5l6QLCV5ADEViWEY0qwtfOmAZvpNIRWfjPpj3zHjBD56eI5gHxidZN4Mi5/Zp8XtlWS+xHnxi2AQO8m9AUP1xrtk8UYMjLuneA+VO1PTfNv0Ssb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1Yj8Xhi; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Yj8Xhi"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1473969eec.1
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 15:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772149667; x=1772754467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Hb2iavLuCFwRbZcUJdleryz74/Q+xg8WkVXrxCwXo=;
        b=d1Yj8XhiNEDcSEBMYSPG0iltvoIdKiu6FndiVhVCztvqTMN/sLm5yehkw+AbZaL2RT
         6gDYQEEdSPjmh7kU9quk2KhOVHvYP4al2ENNvlFxF31NrA9uDeoN/krSBa4Xicaaj3SY
         FkVkZb1SEh3y7CGEnIH46f+tFbHfFxe8ZfUlmcwXT4oXlMSKtMtcU4i4Ml/HH7dT98nj
         n20IupGAK7iFGvKdoe79DnElTMpMo3XEDLNxVLlzfCcESZZu1Wm7a58TJxr9q7tapJjy
         rftfIX6+3GsEq2WEU//+z1iVOZqXpSt7pUvQnYSoVbiNOJgItjQfB+lopPxJJSedmu7k
         OBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149667; x=1772754467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9Hb2iavLuCFwRbZcUJdleryz74/Q+xg8WkVXrxCwXo=;
        b=V36Om1RKzXS+1c8oagdLN22ptOVjSavkXIF79JHsF8eQWpnCiQijK4vrEEnAGUpNPQ
         Rq736Bly79nx12DGKTpuiO9ueAkIGiFM+w8tq6+g1yM/VyZNidtSGAyGqQANT+XhkbHB
         ObMEjeHtY48aU1iPNwiPiaVd00TbNd6P1rnIL3A0786zX/xNmb7nZheTHxZ9NfGF7bH5
         NrmLVQ+v0M1R7kvx8+67sI7v2uNAKmciodMRoOlwnLbyWO6PuwvtW29YiFOwQdKiltm8
         VjqVqLSJvsEIV8SsDJaBZFokBkeabXit9rUWpHF4yDszJCyPVV0rV9RZ8nU1kABHDzqp
         wdNA==
X-Forwarded-Encrypted: i=1; AJvYcCWGSLVmfmzMPDc91xNHK/F1q1jkQt5qCJvmZLknhiLHkXuF+PETdZ8WY4H4jdtu9CrB4k8XopnGx9ejzOoc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9/RKr5CilzMuJNrD79XsiAOOGCmwna0D1tC4+Pv+2NIGNJ6e
	JkvK2qdtodq964sY86D0H9DJJv1RgHifI9wc8hpzXpxhQ/RmOwRUPCmy
X-Gm-Gg: ATEYQzw2KuD3UGCokjd3ywCQasacGlNnGLLQTxnHc5NmBRS+BmBuHWuQhFwD0Xk+OTj
	kfUGAwYYyhFShtTnONMkQNDLLCh/naMDWYCmn0mfdHaoAGbRPBPJ3H4H1A1R04/+uGRTJpAg7Zl
	Suv3sV4HaW0cxbuMnIC9zLpbyOA1E2O4WBe+sbpwz4r6NUT5uaNcj3ns7aGsqIgfzhVLdXTlkSd
	zl1kHXe3FRiftKg5kFn3xX/3Z9l7iDrz7XdqDX4O7pDJm/Vt9Jeu+U1lYp/tGzZEGzUN7M4MN6i
	MTbZYzuHJq7rZEw1MErD09I6+fr+pB5WAfU0bk4d6fQp3CS8gC3VOnPF6eE2+ZRqdo5se32Iyo6
	HAYwojvNQGQJsgktRlDNEF+LTszRMSi4jsZvOk47xyKY8Mc1n3MaVUBsSDul+eTsLZG2A+lLZ8+
	SloUmJMqbfn4Ijz4cTDgTxS58TcbZLsQ5mbsFooAJC+0KCa4ljs+xeFDBksrQP68yyrrSFot2Ko
	Q==
X-Received: by 2002:a05:7300:fb89:b0:2ba:72c3:53c0 with SMTP id 5a478bee46e88-2bde16c8443mr353009eec.0.1772149666732;
        Thu, 26 Feb 2026 15:47:46 -0800 (PST)
Received: from localhost (99-122-55-39.lightspeed.sntcca.sbcglobal.net. [99.122.55.39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bce276sm2849248eec.3.2026.02.26.15.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:47:46 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	David Gow <davidgow@google.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] rust: macros: add configurable initcall levels to module! macro
Date: Thu, 26 Feb 2026 15:47:34 -0800
Message-ID: <20260226234736.428341-9-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226234736.428341-1-thepacketgeek@gmail.com>
References: <20260226234736.428341-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently all Rust modules using the module! macro are placed at
initcall level 6 (device_initcall).  Some modules need to initialize
earlier in the boot sequence to provide services that other subsystems
depend on.

Add an InitCallLevel enum representing all eight standard initcall
levels (pure through late) and map each to its corresponding
.initcallN.init ELF section.

Expose this as an optional `initcall` field in the module! macro.
When omitted, the default remains level 6 (device) so existing
modules are unaffected.  Example usage:

    module! {
        ...
        initcall: subsys,
    }

This only affects built-in modules; loadable modules always enter
through init_module() regardless of the declared level.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 rust/macros/lib.rs    |  4 ++++
 rust/macros/module.rs | 56 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 83dcc89a425a..cfde59e81cdd 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -135,6 +135,10 @@
 ///   - `alias`: array of ASCII string literals of the alias names of the kernel module.
 ///   - `firmware`: array of ASCII string literals of the firmware files of
 ///     the kernel module.
+///   - `initcall`: initcall level for built-in modules. Valid values are:
+///     `pure` (0), `core` (1), `postcore` (2), `arch` (3), `subsys` (4),
+///     `fs` (5), `device` (6, the default), and `late` (7).
+///     This only affects built-in modules; loadable modules always use `init_module()`.
 #[proc_macro]
 pub fn module(input: TokenStream) -> TokenStream {
     module::module(parse_macro_input!(input))
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 4d2e144fa6de..1e210fee4506 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -436,6 +436,53 @@ macro_rules! parse_ordered_fields {
     }
 }
 
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+enum InitCallLevel {
+    Pure,
+    Core,
+    PostCore,
+    Arch,
+    Subsys,
+    Fs,
+    Device,
+    Late,
+}
+
+impl InitCallLevel {
+    fn section(&self) -> &'static str {
+        match self {
+            Self::Pure => ".initcall0.init",
+            Self::Core => ".initcall1.init",
+            Self::PostCore => ".initcall2.init",
+            Self::Arch => ".initcall3.init",
+            Self::Subsys => ".initcall4.init",
+            Self::Fs => ".initcall5.init",
+            Self::Device => ".initcall6.init",
+            Self::Late => ".initcall7.init",
+        }
+    }
+}
+
+impl Parse for InitCallLevel {
+    fn parse(input: ParseStream<'_>) -> Result<Self> {
+        let ident: Ident = input.call(Ident::parse_any)?;
+        match ident.to_string().as_str() {
+            "pure" => Ok(Self::Pure),
+            "core" => Ok(Self::Core),
+            "postcore" => Ok(Self::PostCore),
+            "arch" => Ok(Self::Arch),
+            "subsys" => Ok(Self::Subsys),
+            "fs" => Ok(Self::Fs),
+            "device" => Ok(Self::Device),
+            "late" => Ok(Self::Late),
+            _ => Err(Error::new_spanned(
+                ident,
+                "invalid initcall level. Valid values are: pure, core, postcore, arch, subsys, fs, device, late",
+            )),
+        }
+    }
+}
+
 struct Parameter {
     name: Ident,
     ptype: Type,
@@ -480,6 +527,7 @@ pub(crate) struct ModuleInfo {
     firmware: Option<Punctuated<AsciiLitStr, Token![,]>>,
     imports_ns: Option<Punctuated<AsciiLitStr, Token![,]>>,
     params: Option<Punctuated<Parameter, Token![,]>>,
+    initcall: Option<InitCallLevel>,
 }
 
 impl Parse for ModuleInfo {
@@ -515,6 +563,7 @@ fn parse(input: ParseStream<'_>) -> Result<Self> {
                 braced!(list in input);
                 Punctuated::parse_terminated(&list)?
             },
+            initcall => input.parse()?,
         );
 
         Ok(ModuleInfo {
@@ -527,6 +576,7 @@ fn parse(input: ParseStream<'_>) -> Result<Self> {
             firmware,
             imports_ns,
             params,
+            initcall,
         })
     }
 }
@@ -542,6 +592,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         firmware,
         imports_ns,
         params: _,
+        initcall,
     } = &info;
 
     // Rust does not allow hyphens in identifiers, use underscore instead.
@@ -587,7 +638,10 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     let ident_init = format_ident!("__{ident}_init");
     let ident_exit = format_ident!("__{ident}_exit");
     let ident_initcall = format_ident!("__{ident}_initcall");
-    let initcall_section = ".initcall6.init";
+    let initcall_section = initcall
+        .as_ref()
+        .unwrap_or(&InitCallLevel::Device)
+        .section();
 
     let global_asm = format!(
         r#".section "{initcall_section}", "a"
-- 
2.52.0

