Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162830;
	b=FY428ZnSfh/1IWAU09LLWl8qt1MLyR9+bdRnjcC2/pLsYZLkqOSBfuuzK+osqQVsa63C
	 e+U7mipqqR7BIlcVdA8YgfBGZhzEMKuh5XYA1SyUoXEVEn4axYsYNDwf9MPGs1ZAnCwzk
	 GVoQcVX97dVtxxN38lwoEpUL/Xvs/VGXMwTdjSoKe6LEmaNU0/LCDp0eJSxQzO4eFAyie
	 iEd2aQfFXlr/rHCz+mAph4YmEwKxzMjxtxRItlZpz4ayVEZAeKo7IYipBXGE4QbZkExfj
	 efexcKXk45Wht5h+62cuU2/w8IhN8wCIpmleKCGgqEIhQMzr5OYkZQNTEag4SKq7zCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jQvpyKaLfdZKOFmMbpsSFbP7raLwzSlOfDUVM2Aqbec=;
	b=OMAhB4FJi2ASsgLb+eCowxofjeCcfY3Lw4yMN+W80OcBw4h3/MgCIWD7csoAyKAwYqD9
	 oGrANXuBqanq+1Uh505wgkOlvlC94CBcwa9EFQZ+VgI+fjhR50kSwuxX++uekD5hXS8Qd
	 mYV+UQlglZaRGdu3J7+jfSZ5kfis3jRITDl38aOv+w8kEThZbMWdbY4d5z82NvU0b6dm1
	 rrdB1Ekga9SN5cQwoOGg8Zi0izXrozKhodN0GMoiya91eTx998RyYS9QuzMFA/kdr8uzt
	 RmPsEP3KyLzBIC5okuHFX1ChH5rWSvW6XXqBQimITQeWVVlVpy88Mzq1gkLxUVmBP8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fc5AM36G;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00AB60A2607
	for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 08:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F00AB60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fc5AM36G
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be416e603cso401588e87.2
        for <linux-modules@vger.kernel.org>; Fri, 20 Nov 2026 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162828; x=1795767628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQvpyKaLfdZKOFmMbpsSFbP7raLwzSlOfDUVM2Aqbec=;
        b=fc5AM36GdktGMDpoqt5SSgfE5z2ejcEw0do7btOxbCGr9edQU+oAdfSBVJ0shBsOZn
         Y+tjijkasKiGMOjAABMHTdUBOMTv4jSizprmMg/cswB85i6sXT/SqUVT7e7NDPLfc0O3
         ak9zxhgOjl9VBO13/yt3Mb3Gf9Of94k6v8XenNO+gkHrt9M4EcIPzSJTc+95EB1MQ85S
         MueMUhy0sunRIo6gXwfk6TybGdaAUgxanN0PSCqioSaDlow8vsXepsZKLDiAllVCOkQ0
         QvSIu59sKN1/ZIoTxfyERrqzPflJHqpbXb9f+RwsXFdNaZh1+XA/YQPp84HP8yiwK2xS
         TZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162828; x=1795767628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQvpyKaLfdZKOFmMbpsSFbP7raLwzSlOfDUVM2Aqbec=;
        b=kFlmos3ZGKW7jKJxdC0uhGsgdxG0h3Rbia9nhCqu5v2Be9GrrpCyZCpcBjnZVxIhly
         FziPe82XGiaPgHAkx7GOFtURFVVNIhZyy0qE/vozg9kobKM41PAQkEUj4oyEoq6JTo6k
         gukWc9a7zUz5ofcsN8nX7+WH7tzvaG2UnAMR17EO342KwYTV3nzjxYW5YXdHosEw+rus
         0Kb6gY4Z2VSrKLvtgGIvFflEXT4/H8fB19TGoXrsfi9GraMF/msxmDUkzI1Qsg9X7jG7
         mOcu6UaXyq3/BJvFx+taSCSGWFYEEIILJXrygxpKjoRjD/zVnnQolu/+Hllg19znxLW+
         d8vQ==
X-Forwarded-Encrypted: i=1; AL+hErEEaBoa0sXeZDowuxByc9Wky1PjvSJin+1NEp5yK1nMgC521TkjYRtdoRPQnSAIvQ0WRVNvNYOppFA3jtvE@vger.kernel.org
X-Gm-Message-State: APuU4Z/kZGVcNI6cP0XuwwZy2xYuC5HAd2SiQx8ArbAj0KAPIKbAzrsb
	d1xdaoyA57thirjg/zoyXrgUT72v3QjKh32DVHlss4k0weCaXRdUupN9
X-Gm-Gg: AZFdTZdCPxJqZ2JipP9ABdMzhCtEVaAslh1qxRtKONVoOU46jr5LAGT4+C/4aNF/KkE
	Y/8XES3H/LbyWMeiQeRX0e1IbGTva5jYFQ2CWNNr9ISmo/54OyRt/+Ek8mUuAp+2GLffm8f9FFL
	PPjQduTWxBHb96ZpqXY5RA3q5FvBLCLsY5DZX3CRb3ZfiQMpxRpOGZBtXOzelYqmQAHSCvarWLx
	F7gBq9USAgWISZq/TW6dB3cxAApP48t0FCmGfFmNlP8eBslRfcB6GseUYUCFX/Gh5/882ab8UZH
	IHLksjRnsNwXZHOK7si8npXZGaxj9sBmGwZlCMMz+HwEiLzgTAez6yk8h6MFe48dxxStVKqDslQ
	h4Ri/JKEIL3lxzcgu7+1AisXD9rsgnJEBBFHdcZxCEIN1x0Sg0tQ3Q7RFCHV/UifGdg63NScYot
	fHEeVb+KNdbhCDOYfhArhRgPG+eTbCpS/0rqiQGrvIC5Ttn+Pfg1b79p1FG3irZK3NYACo4QWLh
	b/C3q5ERXU9Rcwe37VVv6kSCQYbhu4t2XgPP6Nj66cONtGjx7vtrhhD9X2aGfTrbZ1gsWEDTd7W
	npl55hDoiZiXUsPhZskqVh0JOZCsv5i6s+qejJEY1YXbYmWjbpDEfPEoKg==
X-Received: by 2002:ac2:51c5:0:b0:5c1:ac84:668a with SMTP id 2adb3069b0e04-5c1bc7d39eemr622417e87.29.1795162827934;
        Fri, 20 Nov 2026 00:20:27 -0800 (PST)
Received: from archlinux ([194.28.181.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd04451csm399958e87.59.2026.11.20.00.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:20:27 -0800 (PST)
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: macros: document emit_base in ModInfoBuilder
Date: Fri, 20 Nov 2026 10:20:24 +0200
Message-ID: <20261120082024.17776-1-mbkchelofficialdev@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the emit_base method within the ModInfoBuilder
struct. Explain its role in formatting metadata strings, handling the
differentiation between built-in and loadable modules, and managing
linker sections and conditional compilation.

Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
---
Changes in v2:
  - Fixed the typo in my last name in the From and Signed-off-by lines.
  - Reworded the documentation: dropped an unverified claim about the
    reason for the module name prefix, and documented the `param`
    argument.

v1: https://lore.kernel.org/rust-for-linux/20261028155005.174417-1-mbkchelofficialdev@gmail.com/

 rust/macros/module.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 0a7b9e24c..6f4aacfe7 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -49,6 +49,20 @@ fn new(module: &'a str) -> Self {
         }
     }
 
+    /// Emits a single metadata entry into the module information table.
+    ///
+    /// This method formats a `field=content\0` byte string and places it into the
+    /// `.modinfo` linker section, except on macOS where `link_section` is omitted.
+    /// For built-in modules (`builtin == true`), the string is prefixed with
+    /// `<module>.`; for loadable modules, it is emitted without a prefix.
+    ///
+    /// The `param` flag selects which token stream receives the generated item: when
+    /// `true`, the entry is appended to `param_ts` (used for module parameters via
+    /// [`Self::emit_param`] and placed inside `mod module_parameters`); when
+    /// `false`, it is appended to `ts` in the main generated module code.
+    ///
+    /// The method also generates a unique static identifier using an internal counter
+    /// and applies `#[cfg(not(MODULE))]` or `#[cfg(MODULE)]` based on `builtin`.
     fn emit_base(&mut self, field: &str, content: &str, builtin: bool, param: bool) {
         let string = if builtin {
             // Built-in modules prefix their modinfo strings by `module.`.
-- 
2.56.1

