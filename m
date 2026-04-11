Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497F222580;
	Sat, 11 Apr 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775912600; cv=none; b=ud5Bxlf62S48JqGfUvzFndTPdNB+MsrMexJ0tt4H9fIjjJZQ7EWIbADC1JKO3UAMSJ/eBaArVQUOvrETjS9OUCKdiJ20iBbjabu0uk8VTtomFUWjvNY3IBb65fszK0UhCfdZdPZ5OpWakvXq1kLt4sslkj47EXkTJbVoNwNjGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775912600; c=relaxed/simple;
	bh=C98cBPZXiFfKy8C8RqL01MOAH7u/ZaqgoiKxK+LrAZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQMKdneRq+2Em63oepbU5arUNJN5vjqStC/0IMwv9DCPzsSd187/MIQVKMwvCRNEyYNtB67nTKxKm+shdyjl8eOiYOc/7l27KVAt7qOo50aQsRZG42gEG/Tz1XOcaZdwosP/OaaJtupmtOupCe4RwOV+Vjm+vGFFaPzAWZfdZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=mdxE+Jcv; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="mdxE+Jcv"
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3a5a3b14e;
	Sat, 11 Apr 2026 21:03:01 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	ojeda@kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: atomlin@atomlin.com,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rust: module_param: support bool parameters
Date: Sat, 11 Apr 2026 09:02:54 -0400
Message-Id: <20260411130254.3510128-2-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
References: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d7ca37abd03a2kunm330ff492110e81
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGBoZVhpKTxpJSRpOTU1MQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mdxE+JcvqoYnSozh5Z0vdKHEEN9IO5h7fnVmzX7BYTps0KzjzCPGR25hG7cdj3r4XW4mUo8Lb98eFt0Cz+a667hatssgMMx2GjiV6e9lRt5enR70gmx/SxU4pZk7hmlvLgJPUNfWVcRoiR0etLaYEH5SZwBGX8B32UmqaneGdsg=; s=default; c=relaxed/relaxed; d=ruc.edu.cn; v=1;
	bh=7J+NbGgWORvyUQjrxluVhEHOF1XbM3sLUWLgh59wiRM=;
	h=date:mime-version:subject:message-id:from;

Add support for parsing boolean module parameters in the Rust
module! macro.

Currently, only integer types are supported by the `module_param!`
macros. This patch implements the `ModuleParam` trait for `bool`
by delegating the string parsing to the existing C implementation
via `kstrtobool_bytes()`. It also wires up `PARAM_OPS_BOOL` so that
the Rust parameter system correctly links to the C `param_ops_bool`
structure.

For demonstration and verification, a boolean parameter is added
to `samples/rust/rust_minimal.rs`.

Assisted-by: Codex:GPT-5
Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/kernel/module_param.rs  | 9 ++++++++-
 rust/macros/lib.rs           | 1 +
 rust/macros/module.rs        | 1 +
 samples/rust/rust_minimal.rs | 8 ++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..04ce9eda6731 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -5,7 +5,7 @@
 //! C header: [`include/linux/moduleparam.h`](srctree/include/linux/moduleparam.h)
 
 use crate::prelude::*;
-use crate::str::BStr;
+use crate::str::{kstrtobool_bytes, BStr};
 use bindings;
 use kernel::sync::SetOnce;
 
@@ -106,6 +106,12 @@ fn try_from_param_arg(arg: &BStr) -> Result<Self> {
 impl_int_module_param!(isize);
 impl_int_module_param!(usize);
 
+impl ModuleParam for bool {
+    fn try_from_param_arg(arg: &BStr) -> Result<Self> {
+        kstrtobool_bytes(arg)
+    }
+}
+
 /// A wrapper for kernel parameters.
 ///
 /// This type is instantiated by the [`module!`] macro when module parameters are
@@ -180,3 +186,4 @@ macro_rules! make_param_ops {
 make_param_ops!(PARAM_OPS_U64, u64);
 make_param_ops!(PARAM_OPS_ISIZE, isize);
 make_param_ops!(PARAM_OPS_USIZE, usize);
+make_param_ops!(PARAM_OPS_BOOL, bool);
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 0c36194d9971..95bc3f066b49 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -52,6 +52,7 @@
 /// - [`u64`]
 /// - [`isize`]
 /// - [`usize`]
+/// - [`bool`]
 ///
 /// C header: [`include/linux/moduleparam.h`](srctree/include/linux/moduleparam.h)
 ///
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index e16298e520c7..feafa0c1623c 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -197,6 +197,7 @@ fn param_ops_path(param_type: &str) -> Path {
         "u64" => parse_quote!(::kernel::module_param::PARAM_OPS_U64),
         "isize" => parse_quote!(::kernel::module_param::PARAM_OPS_ISIZE),
         "usize" => parse_quote!(::kernel::module_param::PARAM_OPS_USIZE),
+        "bool" => parse_quote!(::kernel::module_param::PARAM_OPS_BOOL),
         t => panic!("Unsupported parameter type {}", t),
     }
 }
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 8eb9583571d7..fedf5be1f713 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -15,6 +15,10 @@
             default: 1,
             description: "This parameter has a default of 1",
         },
+        test_bool_parameter: bool {
+            default: false,
+            description: "This boolean parameter defaults to false",
+        },
     },
 }
 
@@ -30,6 +34,10 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
             "test_parameter: {}\n",
             *module_parameters::test_parameter.value()
         );
+        pr_info!(
+            "test_bool_parameter: {}\n",
+            *module_parameters::test_bool_parameter.value()
+        );
 
         let mut numbers = KVec::new();
         numbers.push(72, GFP_KERNEL)?;
-- 
2.34.1

