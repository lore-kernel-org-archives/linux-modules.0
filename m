Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202620;
	b=whjPk2FXw3Hjyfwdt4HTlhZYrS2e9G5q3S8Ps4UzNeg3eZKR23M4bCMQ+3Z9fg0Ds8Lx
	 SfP5vQYN5qRXUC9tR4K84djUqM1idDvnH7fBa9yMPp2xDMt0T+8qqglSVSluXDq3q8hyk
	 jRQf3dNh8NZgM0NpSUSoHhzUTwYY2v0esB4rNGBzaotzDbVx0k0eCW5ncnvrItkuCIShc
	 dk3CBvdfwhiFOXoOiiWK4m238AMb9XKFVH5UNvXg64nlTTUX7EXOeVI38q9qbn/mND1y8
	 q2tbTRP9ihfiJeTkNa+yXN6YeQM4XNO0YkjAGtdybl5sMvMORtaCvaXBkuXnI6OD45g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wj4LX9xOsHpuGRygOr/nDK8i03h77TPrsXBsHHo2CzE=;
	b=kNNXuPD9rPQsDy6Z7W7pr68nPRkHcfD7AlpthJTr1eyklDVt6BTtfHppobwZdeL+MCq6
	 tW6oqzLcWp6M0HL3lHuQ0DzZWy0kFZThO9dY0CNwsC4+CBREsAylq5Oan/a03r1DoBKRC
	 gtowUCawZ2dx6PK08YlLZz2hmWzYX/kfCRw7C7ptD0Jom7eZ7e6pLiRmO0j6cyaYquSKH
	 jaAI8H17Sp5tE5RbToOQrSdDsL8uRB5j84laJ0aHn+tjQOdF6GH3eOvwGo5lVQv5t9V7j
	 puEaHpU8FPIXxCxyLSPGH1BLLygkPLaDW50o4yPVFZpxHylLYgl+ZrBrgKdKszeRC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L3gP8nyH;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B6606A31A
	for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 15:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 036B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L3gP8nyH
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso1374827e87.0
        for <linux-modules@vger.kernel.org>; Wed, 28 Oct 2026 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202618; x=1793807418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wj4LX9xOsHpuGRygOr/nDK8i03h77TPrsXBsHHo2CzE=;
        b=L3gP8nyHEpt7c0+mIxQ4RE0XFyRCO1UWhX6RArQV5e67OLxg471Fdc/XET1Yu1ILQT
         Q6iKZ1OgUaRmQtlh4i2mKr7l/f2l602LAkSGYOvjK9vDRVLOmbqZLS3xOij4o2srjPFq
         PU/wglL8p4fQxbbWhbxRERoDprueyz0T4yBdcAgG7VUDSie4QeGTlyqISmaB3bUix0eJ
         4yE7ohInOuyfj8YnxkW4OaOd7FaZiI/tl/oLRnw2uLfNbrHYfSsEaphe5v+017JWijzi
         TNtEUKG2nCH39y44cB5F5TZ/M2K8TvBGllYGJVjWSUxD9D8GsPoDOUMAVX8JYgpKiP9g
         V7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202618; x=1793807418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wj4LX9xOsHpuGRygOr/nDK8i03h77TPrsXBsHHo2CzE=;
        b=u57KUTPp6PZ+/RPSsjzEO4zF2pMOU7RfUVDnrS2FPAvyrKtB90BfaceojS9CQ/3C89
         /z1chdeOD9nEdmLE+e/HOJFZJmOtXjwTl+eXAEcbNE2/ZeAqeyOauWdy9gzrKrzR55Uo
         OnA1WMN2nBNJoEGDto7LnfOJ56sFPBKTxx0Dh8ZwJsGQQm4UtQZGKtGiDAMyIIHtx1l9
         x653LZE+u5wO6G8w094FjznYXLKSD+FFFzuUyC3GroXlXcwGOGw4jlXn+DOhyq5xhj04
         D3BFOcRmVEDzULABCSt9vyT2byltuk0JgtU59Ojhx86qOuWIaNulZdudCI3CAqztv6kv
         Hs4w==
X-Forwarded-Encrypted: i=1; AKwUvBxVK3sigw+iQm4o1H2OZK1oPRAPMjp1pZ3Kj5y9QUsxBm3v0cLAXi3j43WT5MWg2Gf1E2KB0KJ0S4p/oHJv@vger.kernel.org
X-Gm-Message-State: AFq9FYIT+nXXG1xIkvEWjuv+wjuvgYr48XMSc3Wf2hch3r5iS54OWzHU
	+/yrhAN7rWgF4tWcKUmLi6oqOzx2/D01EOfnOEcz3TIbYZ48q/PJsjNg
X-Gm-Gg: AYBFou30wpt3PxMCf9SiJ6SFD6nplkDGMe5F7ALvXrTxLeLhtS4B4GzBQRMpoB+xXGr
	jHTNj6Ude+XP4yw0DVQw9jkFb9+fSJhncEsdQ/OAWIXqSTUpoDQ+woa8vZAfXShRVhDl4VL1cLz
	7OkcjVPQxcWI/PM+axQudBBrh71jqjLusu+fqTiGImftsI/cg0NXjNScTK7VEaIWrCLwHqUS2E2
	4qkRwgcUV3TPfu6zcNjfbgFfTH1Y5FMkbXKulh/JuFIiLyzQxJ7Q+FoebywIwZ3FxhX7xt337FE
	WrZ3DOqQ3bV40qINJcjEZRkYKxLHY+WA+1mbyMfVx3dQipFWEpoR96E6D0+kj+w2wKZmKZxrJJh
	YVEDUP/kUZll2/E99ca0gB3xnE/jOhFC8W44O0yacBxX6gtDZ1N3p6TTp79A5wTDHBHyLcWbOtQ
	Z/atwXDGd03bKtp8OQcXfUmjNH2/keBMUVWAEKX/NZd4Q0OvLMVn/KMj5fskO1iBPqRELTKq4Iw
	jO498F16ifMksF5CmP7t/fi8uifFipNw6hTz+fiANyf4OzRB5MD8XvFHuTWm89FvrsJID7q0vmz
	QMUxwronx1GLSZb0CqNyQW0907TGSBcAk30Cew==
X-Received: by 2002:a05:6512:a83:b0:5bf:b93d:a85b with SMTP id 2adb3069b0e04-5bfcad893eamr1077228e87.25.1793202618007;
        Wed, 28 Oct 2026 08:50:18 -0700 (PDT)
Received: from archlinux ([194.28.181.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfca5c6ffasm694002e87.80.2026.10.28.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:50:17 -0700 (PDT)
From: Ivan Tverdohleb <mbkchelofficialdev@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivan Tverdohleb <mbkchelofficialdev@gmail.com>
Subject: [PATCH] rust: macros: document emit_base in ModInfoBuilder
Date: Wed, 28 Oct 2026 17:50:05 +0200
Message-ID: <20261028155005.174417-1-mbkchelofficialdev@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Signed-off-by: Ivan Tverdohleb <mbkchelofficialdev@gmail.com>
---
 rust/macros/module.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 0a7b9e24c..6f361013f 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -49,6 +49,16 @@ fn new(module: &'a str) -> Self {
         }
     }
 
+    /// Emits a single metadata entry into the module information table.
+    ///
+    /// This method formats a `field=content\0` byte string and places it into the
+    /// `.modinfo` linker section. For built-in modules (`builtin == true`), the string
+    /// is prefixed with the module name (`module.field=content\0`) to avoid naming
+    /// collisions in the final monolithic kernel binary.
+    ///
+    /// It automatically generates a unique static identifier using an internal counter
+    /// and applies appropriate conditional compilation attributes (`#[cfg(MODULE)]` or
+    /// `#[cfg(not(MODULE))]`) based on the target type.
     fn emit_base(&mut self, field: &str, content: &str, builtin: bool, param: bool) {
         let string = if builtin {
             // Built-in modules prefix their modinfo strings by `module.`.
-- 
2.56.0

