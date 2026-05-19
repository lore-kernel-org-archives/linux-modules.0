Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142F395D87;
	Tue, 19 May 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171978; cv=none; b=VtuMVM0qVNlyrpXl4cTLPjpOxmCZxOZMwMeCvEWJ3MxLwHijiyH8fG/oe5QE78PkVTGvE5ORPjZyPo7MMzridMiBAct7KQ5NgUUfqqOJzz22L9tCjHppl9GMBTAuFxoE2Ha7UcDtaVrjpHpdGWTjcahcHXYcblXyEgtEc8ZJ9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171978; c=relaxed/simple;
	bh=I3viC+xei+z7Du+zKhaAbdeTTw0QaX58PY37KUiWlx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxjrwTxlcr0YTh3hljzhp797VSTxkJsMBu3Mek1s3sxK8+MjU/zJeYZcM5WoasxxwpvEzsgB4OZNtGUQIVPSluo7gMVTnGMWJ4l6s8qisWFT1ZtXJD8DNbN422ocXtCdFvPA0TOUU33YZDwNpAoR+v/OdCtilhz5pQM3xjsIuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=0DWDv0YS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="0DWDv0YS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79D26C4AF09;
	Tue, 19 May 2026 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1779171977; bh=I3viC+xei+z7Du+zKhaAbdeTTw0QaX58PY37KUiWlx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0DWDv0YStWDiNp2eRzgkI7+ej1qmXthujxBH+MsQWflTKP/xdZvf2orjR5g3iiH35
	 956R+3pI+1lLcuEUKFb7dw8KyPWsTc9rYB7VYILW63MTxBe0h0gmu7lOGkC8GA2naT
	 DvVTWmtKDvAx7VHzGd757z7H165p58/kzANNl3QM=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1DCD4F5B;
	Tue, 19 May 2026 06:26:17 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 19 May 2026 14:26:20 +0800
Subject: [PATCH 8/8] samples: rust: rust_misc_device: implement
 `ThisModule` for `RustMiscDevice`
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-fops-owner-v1-8-2ded9830da14@linux.dev>
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
In-Reply-To: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171975; l=782;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=I3viC+xei+z7Du+zKhaAbdeTTw0QaX58PY37KUiWlx0=;
 b=rU+vsujc7ps9LVjZzU2EMVWbRxlsY4wFfumiMPvocW2zu/qAFSe1VduxhoLk7OyuG0fnmJIIt
 Eprmd69bn3tAxqv+SqqTQzC3dXJdIYh/YoZDUxIWVdu64Gch28eCwMA
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684

Set `ThisModule = RustMiscDeviceModule` to provide the correct module
pointer for file operations ownership.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 samples/rust/rust_misc_device.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index 41e26c825060b..a4b012a35b5ec 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -176,6 +176,7 @@ struct RustMiscDevice {
 #[vtable]
 impl MiscDevice for RustMiscDevice {
     type Ptr = Pin<KBox<Self>>;
+    type ThisModule = RustMiscDeviceModule;
 
     fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Self>>> {
         let dev = ARef::from(misc.device());

-- 
2.43.0


