Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA0225A3B
	for <linux-modules@vger.kernel.org>; Tue,  6 Jan 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715991; cv=none; b=ZD/EtxSmex65So3J0q7fZCyUudVf3DkHjO7naq3egLCPjaB7qtwCmjNIDmcTOg9r5mre0oPzmjn1FxHctqMlLobnN68aZWnvy430WWqgBzPKvQ/z6G3W5ZZUwZGXhYb5I/uBhL0RfzKokGQWcn2BrqrcPf3c1j8Lu2amJ4g00Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715991; c=relaxed/simple;
	bh=NbSZJOFudokz6C+njmD0VOJLlYmt/34Y4GRpm6Ry5SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnJvjdEbnUFYj+rQZUgS+JyZxI9p8B1KwJEwN46RHTSdOQZtp1YlzAlbIj3GE/3e9iGniknjbOStz4R5QWZpMhrDIDsH/Ggd3Ty2fhJwObgaTAPeaY5x/rMndrH8tR4Qz7OTHjjYzk68qghyDJ+Whn7Iy5UX+NQCVOJb1+cHA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVUmsUD0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVUmsUD0"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a3a4d3d53so13716101fa.3
        for <linux-modules@vger.kernel.org>; Tue, 06 Jan 2026 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767715988; x=1768320788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJEsrOJPO59o/eeH09HtsmYQCeq/k0b3qKzFe+dbMbk=;
        b=TVUmsUD080N+VrEELv+AkezLiDaQ6Otrk1yY8QOuSjHSZ0ZqqSxIioidlP7yDfI9Vp
         bgI1E6XOWA7aveE1+I/Pe38MlHLIuZrKmoKrjt2uyrI59zoGjOOzSWvY0QHFnmqvZrjF
         +8s9p68R0Kfjy3+LxwGR35xMS80s6ciB6TQliS3TIlK1tiY8EtFlmvexq2GVKqIWV0aQ
         6VsyntkP3duobEpnjX34tceKtYbUCNhxX3v4uqwsYgWZVe915ZAeQvYePAX6C/arjC8+
         yaP6ccsQLK4TXPH9d43rmNtl4xGAkgv8yMcmHRW/iwYc4W4eyjaqZN6MCIxRMzm4dHe+
         bNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715988; x=1768320788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hJEsrOJPO59o/eeH09HtsmYQCeq/k0b3qKzFe+dbMbk=;
        b=OmHBdDmi+sy8HxGsbjwjHpEjvFNAIhxyNecY+j1avt7GGaGiND7p0n8j+4zyAW+Rxn
         PXBYKqnbfa25/ke+RSh1SqYQjpjpOi2ieLKAbGrm8VUjPxJcSEPUFdZ2DN/9tX48yvek
         Sm6hy4IBbK3NQVn0gltd8CETODJQwbKt4JXixb3vfujVTEAdExqN4RzvOP3z/MDuMNoe
         2ndl7lSuVnRsHn3g3KERF3+bWAgLgw9fBXrpIUV02XpUnIZzepneXP7nLihY8pPU4SVM
         6UAjCqE7kjfyhq9D8d15k6O219wvtUL7haGLJ8kums1CCOb29sVqhAkgOsT42XmxymKs
         q7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVF88Von3r/dpZ+sDF9ggkxYhWQ7My1aYi/Y5NFY8SVRt/U72xkpMo4DjFp5TMMJ8xhZl1p/O8IIf1MAM+S@vger.kernel.org
X-Gm-Message-State: AOJu0YxSo3OMejaTFV4yYoZlVdEZyabhyLY7D1JjlTK9460Y/ZYFEwl1
	alq4EvpqO989+1wtI4h7BqeM+RluS7DExW9YlILn6+Z4U8Ht1NQWeC2P
X-Gm-Gg: AY/fxX4y8omsfU1dsXhv80K34uv2/ifZw7qGpeESau34bJFAokzBNpVQbE1JIyzdJEv
	m0YY1qBJTKuecgA8ZCoOylAW2fKACcDh4UJJBAxGJzXpfbW0Rsi/DDM0JLBuc4+XcCnpYTeqZel
	UYkkjakO/WLg4TR9Y82/+Md523UpEpajajyXePQIWt6XyvjLhp0e1IXNVGGICFmR9lkkFMMqeY4
	udsYfzz2tTvyTHlXrTZ5D5/L5cErICy9nS5x7BzR6RyddRnJhj31QveP7be0uO5VHujIXVnIi8X
	oWqkOO4f8Z66bl0mixPKbqklnoTmE79MSblK8WvCrMIu6IDaNQ+QVBfVME5lnsnz1aoI+bSlRIh
	N3EAiqVXQNIfk0tzbwaN5tewGbb7h2FjpPUH4xlEdrUNkBY9hoMm3k/7HT/ltOApQNXHmt8AY+X
	YSkqfUfA3jf7lhMFn7x+jR6HC+gOZnjGllHg6KC3lPKqPG1B4+T55y0cHR/IvIaYqlx8fo3faR4
	UUuWQ==
X-Google-Smtp-Source: AGHT+IHKaBOSwm4vp1JX09Pd02uyRduDey+97mZMIBnf1kbFiov8dfuABleYNBj8DwXxWVRLUyVm9w==
X-Received: by 2002:a05:651c:1542:b0:37a:2c11:2c5c with SMTP id 38308e7fff4ca-382eaae3114mr10488351fa.37.1767715987833;
        Tue, 06 Jan 2026 08:13:07 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-180-149.bb.dnainternet.fi. [37.33.180.149])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb91dfbdsm5256091fa.44.2026.01.06.08.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:13:07 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Tue, 06 Jan 2026 18:11:39 +0200
Subject: [PATCH RFC v2 01/11] rust: enable const_refs_to_static feature
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-this_module_fix-v2-1-842ac026f00b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767715983; l=837;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=NbSZJOFudokz6C+njmD0VOJLlYmt/34Y4GRpm6Ry5SM=;
 b=Gfhq34snEkIsncWb/32XzJ7mDnGJI9NzJRtuJ5elT9FOTK96SZFBM57vqx6E+sIWZvobIIJuP
 PN2M73QNsKNDRKn+ZIbZM0I884SvUA/BxyVpF2M3n+Jph1Hj6VPLvXV
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

Enable the const_refs_to_static Rust feature to allow taking
references to static items in const contexts. This is required for
using ThisModule when constructing static Rust structures.

The Rust support already relies on features available in Rust 1.83, and
const_refs_to_static has been available since Rust 1.78.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 rust/kernel/lib.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6d637e2fed1b..510d4bfc7c2b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 #![feature(const_option)]
 #![feature(const_ptr_write)]
 #![feature(const_refs_to_cell)]
+#![feature(const_refs_to_static)]
 //
 // Expected to become stable.
 #![feature(arbitrary_self_types)]

-- 
2.43.0

