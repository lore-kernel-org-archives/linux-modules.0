Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598F338598
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716006; cv=none; b=nF4tZjDKQFwLYwqHxfJLGgxXmjsJ6CJqlrYSGodxJAKhtUJbx6FJR1PS7b7FR+lwyl74bw7Dfpupsxgm4lPVHj/3hYOEo5ljj0FcABqaFZB8CpJHFIcamW8twdCYKMeP0dpfnu1QOoCQ3T6/2rxSqdoF81Ics6ZaynH9rrfPesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716006; c=relaxed/simple;
	bh=HXsmrNNEr+H1R93npODROo6Md8lvxfZavxKoxrx9XrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnuekmiXx4JG52Qf29h3/xpqXiPxsuu48yeY/SlzkAsBHQdENQXNis+BSy3gc1KrHn9C/yI7A19jOOyDMdxBgysUa3H88hPmjoEwAEbvEC/s/4GZ9OYXfhuBVtYp9JxUFPyMbeDqitr/1Zeyudt7R2dxtYy6a8CixwFWXhTiV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOMfVa29; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOMfVa29"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37d056f5703so9472411fa.0
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716003; x=1768320803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA4SPNhuMX5XCZ5OBbakMPi2P9GAq2DqeqD/xi+6gT8=;
        b=mOMfVa295tY7LkIeYZsnWS1Rdske3pgJY8ADTuX0xsp6a0wfNtA/RgpbASh6gwkbie
         LtoGdyKnfi7sN9JFObruv9dlj0yc4NqvSaxn1nqg0KZxrg5ivQ38cc6WQuNz4rB17T9J
         TfSfxiaKcs3MW2trseyAhouSny0xDvoH4jQNvJbijvt3WFWcIN5ipxa1Jn0AXAmM4zEx
         odgUwfes6qD9m88Edduo7I4HSxWKDqovjndroELwdcgdnuqpK/nRxBlu8p8Ny2Bcctv9
         P45MdXltu/tAr5HhUtyE27wAKpjC/zI2UtqJxwLkbGOOwFE9RjHDSCr334ohfDyJuYdG
         YmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716003; x=1768320803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jA4SPNhuMX5XCZ5OBbakMPi2P9GAq2DqeqD/xi+6gT8=;
        b=TIfWRbxiWrKK3priPiZ8kn5IpA2/Tj0hOYl6sXnbzvVP2Q+BSUqWRBZgj7YxRWZXYq
         GF9m1MODwWUKAMaHA7O+6Ue+vZm755UtbOrgUrjUi0MrdM2rkWNOHe4v897+Iz0bWxyK
         McbDx3uiGvabhxzcMu1gmnplbvD37+Ic0xbU/HWqJPkGGDJepePuzIRPksLI0TiQMfi+
         S7HMd04o+HZv423Kr+6yH4gW5RScgdLgWsUc3wDC6MKeaRvsj7BOEvoUypizIr9z3eS1
         vlrOuJqst21zIzkN8rZEFq71C5w4viCQ7LvvWy0PqIB9x0SfnVwzGMPp1qn/Kvmr2QXC
         i4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOhcfwyAoqnJQdVKTBeyKUAFwSxUHGBIp7AP2u3ClJBOH+URvPleYSpMQsVphLRVcXowkpRtsbvi8tvYp/@vger.kernel.org
X-Gm-Message-State: AOJu0YyeV7IQ+21IX1CK0E93U5vEfcWaIUTv3jUaSZPcN5HXE6zU+Y7M
	WgASZnjTDYKXkBUItzOAR3vKRngXwSziWH5QVWjxesi+pJ7ukAGl2f9R
X-Gm-Gg: AY/fxX62n2pRks8bUDQChHhHuwfHGrX3Q7kmaQ3E/KM7RirFn0Z5D9tvl16JeXOy1bF
	yJLx/TBN2e4cM1dcfvVZJ1p7qyAF44HkivqfFZP7HdzeZp46BMsKKItwxdasNd7VgkAb9eRE92c
	VM3JieDCZ3W0wmgMGzYLmalLNtVG17GY1X5NntqNXf8HgVJSauP+a1cBnfM0La8n7IAzM9WUw/7
	Tl8EePHM+k7wWAM59EFOtVSEF7xI9hBoqB1txRmnB65UXHxlKJTGestpzrZZ6dl4vEaA6PTaWiz
	pFquaU+CSYdb7Hl5RTRa/+hHfnbsh6XID4kpG5TMsVIjNOn8i9kgkd5P7FlCOaVGXmZMonlHDgP
	XRntBltBlR9Qa4NnTWpOxXxdd+slV93YJBQC/Wk9HchNM/JwiEYCzpeiM+xTogvHS1iohcZj8Cd
	8LPpgN4kQ/tX3OnT/1CDkCYJAbmzLvrvFUt6KaFlheWXUfFS7Kw+GFV4bHVxKJorPerMIwX5hPP
	iGZog==
X-Google-Smtp-Source: AGHT+IEDfjAP/q6tl8l2j/q30jjjWobjSIo8yqpbOiByLc5uyBuPPT+WRrg2weBXCsixvQrl0a6H9Q==
X-Received: by 2002:a2e:a58f:0:b0:37a:4714:ff39 with SMTP id 38308e7fff4ca-382eaaa2f8bmr10163611fa.23.1767716002686;
        Tue, 06 Jan 2026 08:13:22 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:22 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:46 +0200
Subject: [PATCH RFC v2 08/11] rust: binder: use new THIS_MODULE
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-8-842ac026f00b@gmail.com>
References: <20260106-this_module_fix-v2-0-842ac026f00b@gmail.com>
In-Reply-To: <20260106-this_module_fix-v2-0-842ac026f00b@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=1238;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=HXsmrNNEr+H1R93npODROo6Md8lvxfZavxKoxrx9XrE=;
 b=5lBBJ8pNkqE/cUVzYPL+ifrN07scK3BAy/Q4cFAaJhkvnZyARbkT2dcTAmw41Pf0yprOIFojh
 u81hnoO3A+YArUkD6BUvZYrXJkWXcEAIj6EBEDw7QQDufIRI4FH8z/+
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

We have new THIS_MODULE. ThisModule is now crate. This is ugly for
reason that drivers should not use as_ptr() directly. Currently binder
still needs it so ugly cast is totally ok.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/android/binder/rust_binder_main.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index d84c3c360be0..fc921c0e1116 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -21,6 +21,7 @@
     sync::poll::PollTable,
     sync::Arc,
     task::Pid,
+    this_module::ThisModule,
     transmute::AsBytes,
     types::ForeignOwnable,
     uaccess::UserSliceWriter,
@@ -319,7 +320,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
     let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
 
     let ops = kernel::bindings::file_operations {
-        owner: THIS_MODULE.as_ptr(),
+        owner: <THIS_MODULE as ThisModule>::OWNER.as_ptr(),
         poll: Some(rust_binder_poll),
         unlocked_ioctl: Some(rust_binder_ioctl),
         #[cfg(CONFIG_COMPAT)]

-- 
2.43.0

