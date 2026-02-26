Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73D3335099
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149664; cv=none; b=HLvcN928dpLwAkVbtDWMGKcM4C2T0GImqrjNJ2E0Y1aZ02kQtgfSl044Kq8KciMxokMnxIdiTaHpkrmpudHH3W212ANCuMFaYQuDOQ0rBnpdM/AmNWtI4i+n8QT5ZYQoxYw81ifch5Q+j1tBwPjJwTMux2QsmcG6DAcI3oOhOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149664; c=relaxed/simple;
	bh=diXsuT8eJT5nS1aZMe0HRgaFMpWk5Il6lizUmS70zew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf+IdU185myjtnDgFcrTZF1oV8SJC5jQVaJnl0LQrmgNxH3NU1D5fjsKIviVWX3plkl48mwcobkhwvxvqGcJezcbu7714kYxP23mdcOdQC/xvloBbl5mbUZ5gkuFxZzmvCpRqvYr4lCBT/CeBABje5aDJsaIY2jwEHvlPPN1c4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbVjp91i; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbVjp91i"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdbd13ca01so2713120eec.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772149662; x=1772754462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5i5WdejKaPItbRozzcqSDHdFPHSAvpyQt6V3+kxZMw=;
        b=MbVjp91i58IBWrvZ0bLFpMYkO/UcDLmdXT9lKTCa6RotSYujw4CdXcboon5KWNvbqj
         vxpSvORZD42q0gbcK8La/s7Mjis8KKRSNQiPJnB84hAY0Gt4e7109nwryPmP/Ul5PMkZ
         r+H0YR8AM3G1JKA+CcJXUBa3+pbzIn212FiKjAXy5FrHccnQEmEMq8r7xF4bZRf5RFT6
         4BiXRcysP1p3gA8jveORAOpc17K66x8ESQqTzYji1FhNVlMF/jkPtI7f2WKbNjqMfJE4
         luB2qrmvBzSAWL7iMvaYKTAmH3cfEMfYtH7vFOH9xpMAzS3DeFiB3q6JcYvGXIypVxFh
         sv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149662; x=1772754462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5i5WdejKaPItbRozzcqSDHdFPHSAvpyQt6V3+kxZMw=;
        b=UYOaJEd+bFOAgqdE1gkMO/CjzYi7dfuBQTEBB1YkFzvZSya9oHmpVpBL4LYizPPbqP
         9XqAhm8CeaTbfEdayEFb31JBhqXBbhMCvAphA7+6O0yPYtik07lzxhVqM2GYCyWnsiTs
         u78sjrzyRrOT1NESUD30cPPsOvO3zEw4EH9/YP0k+tkrkcI6QoRmfmNjJbSaZM2eVeN5
         VjYPX4ws/45LM3LDVekDFU5C2VcuCjiYrL86SpUdMaEv2Ekv1pip9hPkNsOokQFbrtmc
         xeiGO5rairj21Gt6EuckwNa8ULonRS8kwU0ietgnelw7Y3bbGspuMSBjHXkOS0O/gkut
         dnbw==
X-Forwarded-Encrypted: i=1; AJvYcCXHqJwTG3z8Vb7lr4giwv+tZrlSQN3UBKETJ+DWlSTPrqZb+r49ic5nUc8pHx8ax4JEzQ721UIjH5FFS6u0@vger.kernel.org
X-Gm-Message-State: AOJu0YwZatmVoeWn0ibZ5xcuQ5SVJ2yT/iatZaKG9h23eBRK3joB7lp3
	wCOef2jZONVCP1z7sLAlwzKzN31lmgdvWe5nOW6kMyay5nWVxgkgC8Wg
X-Gm-Gg: ATEYQzyIfAHoWZdE0U8udashVDYlRgH+L4JSk4kXs3ErGTGx2Yr4WvA8UxRYfGIarQX
	eMlA6fzH04U4VbgRmQz/nWVV5SiFgjxru6L6SAX8t1rVMLWu5HbE/e18KL24lZP38IF2FBNwPJL
	G/YqDSAfMOanVfXkE9fOKH8R7N6frvpBslql49gImMvvwjlBOFhMxH1bLLxrdj1q7JmAwY3g6Cx
	W03/oyhHYg0jpjwvDsolGO1FEprA9y04+aU9segaovFStK3lUeK9wjUUhPronXsqrOjMpJd7CWa
	JVsHt2zX27G2mA3T2C4S5/BAx2XcM2mpXr6adRdXxL0QfDeYGcFLOhAQsF+MD7X8lMm9tzmYMh7
	rpS4+nvyMqvD+B5Jcn6AlVM78dK6w6cGMgoiZ01/bQx6vCcSCLd0oO6QEu4FiYdco7+HxN8phLh
	K2RBP9+uSDIPJ+KQqCYfFS4mKxmqk4QN58CZa0iECPhX/6ZfSy5hEAQXJAi6p7Yyp9Zl2yYAKkv
	g==
X-Received: by 2002:a05:693c:2c97:b0:2b8:64ad:ad4d with SMTP id 5a478bee46e88-2bde1d32ceemr413421eec.26.1772149661991;
        Thu, 26 Feb 2026 15:47:41 -0800 (PST)
Received: from localhost (99-122-55-39.lightspeed.sntcca.sbcglobal.net. [99.122.55.39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c0csm2819777eec.22.2026.02.26.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:47:41 -0800 (PST)
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
Subject: [PATCH 4/8] rust: module_param: add ObsKernelParam type
Date: Thu, 26 Feb 2026 15:47:30 -0800
Message-ID: <20260226234736.428341-5-thepacketgeek@gmail.com>
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

Add ObsKernelParam, a #[repr(C)] struct that mirrors the C
obs_kernel_param structure used by the __setup / early_param
infrastructure to register boot-time command-line handlers.

The struct contains:
  - str_: pointer to the null-terminated setup string
  - setup_func: the callback invoked when the kernel parses the
    matching command-line token
  - early: flag distinguishing early_param (1) from __setup (0)

Mark it Sync because instances are written at compile time and only
read during single-threaded early boot initialization.

This type will be used by the module! macro to emit __setup entries
in the .init.setup ELF section in subsequent patches.

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 rust/kernel/module_param.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 67ff6f2ea9c2..54379a2bba51 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -26,6 +26,20 @@ pub const fn new(val: bindings::kernel_param) -> Self {
 // from Rust module.
 unsafe impl Sync for KernelParam {}
 
+/// Placed in the `.init.setup` ELF section by the `module!` macro.
+#[repr(C)]
+pub struct ObsKernelParam {
+    /// Pointer to the null-terminated setup string (e.g., `"netconsole=\0"`).
+    pub str_: *const c_char,
+    /// The setup callback function.
+    pub setup_func: Option<unsafe extern "C" fn(*mut c_char) -> c_int>,
+    /// Whether this is an early parameter (0 for `__setup`, 1 for `early_param`).
+    pub early: c_int,
+}
+
+// SAFETY: Only written at compile time, read during single-threaded boot init.
+unsafe impl Sync for ObsKernelParam {}
+
 /// Types that can be used for module parameters.
 // NOTE: This trait is `Copy` because drop could produce unsoundness during teardown.
 pub trait ModuleParam: Sized + Copy {
-- 
2.52.0

