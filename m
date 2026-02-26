Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C433BBB8
	for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149668; cv=none; b=YPOq7etEKjET3SL2i/yxWiKV2wh9G8cL4PCvejJqsw3RfPeNHVHKeTP2ZUd5QdB+VXHKfmixWHff9h819/+RR/Hn6kfzaUQ2GBb8O4RDQ7HbLA5Uti6YUCdRZKcPdC0WQ1aEBSHlg3xYclv2yhqq2GqYUk9/bk0pvECG0CHC+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149668; c=relaxed/simple;
	bh=BAjK7gWmE8NiqPCEPZ+0Bww+M+TFsGuQf188GGuI7Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h71VCYZPXA2G9pxnvm+n5vRd+98uH909l3Teg6/IbOw6FPaH+KPoj2UgHzDOf7x+9K1U9L868HyUxSjRUsSNVhhlsisAf74DO+a6d5oUIc1f0OUQYo5khDoxucFxf+Z13O46OVs0nUZTuFBiQBQGyONp/RBXFf3xnEl6LVXon1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxuvrRSh; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxuvrRSh"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdcfbd0779so1699928eec.0
        for <linux-modules@vger.kernel.org>; Thu, 26 Feb 2026 15:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772149666; x=1772754466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpoHH7pwXOlyNuoaXWey7x0lvhL7U9SeoRRb6VtCgvw=;
        b=fxuvrRShfPuZ7Rr+Hm8Bxm9iS2163sSdeJ/UcrXVi28FZy4u+Mwvj7uMERRHMReCdP
         jHh9+thhpxFomJ7FPNjnqkUVdfHwvVX04ifguXiVwQYguS4tLazoflfbLte+7lpzz8z6
         6N6GM+J2+hxnkiEcSPCMnHUAMuVYun2F+GeMXr7Q3tMQNIxg2g7du95c8BZKvXVhp4II
         Oh8RSH3sreziq/gHLwIKjdlgPMmiJ36OhNuIEBJOl/s8cXM59eFEjav8cjlhYVHyFm1P
         ApvAEtKc1Pyds5gr41DsybndVaDWFyNRj0YqBM12nhfr6z8Pk1NpWCUAJwpsV5cPu6Y1
         zr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772149666; x=1772754466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gpoHH7pwXOlyNuoaXWey7x0lvhL7U9SeoRRb6VtCgvw=;
        b=BjCwnmX9waDkkK1yLddC0UDGFKT9qKFcqfpHTzPw5/uilC1fVakmiLQIVwtTYqv79J
         TNruJRWPY2oHHeztMOqq4YaXqNZFG0G1gk/wcj1yu2PYczDbO01qyTCtHpy7DP9WWiWn
         EqUuVszLw+cYH6ylsB83JTOls6OD1YZ6wEAaR+IA3wopYT55eMzfDCg33TkCEPytPKVw
         a3vidxjETiy7H9S6rUApLwFh/w1Us+8cvFJLzZ0/5G8feQK0VgR+ihm7/r07t50aUKrj
         fkRzj2Av+l9znrcQLZOi60uqN3gX5IRnqGIUw1nKnFYnmmfma1d+vU6X95oXAXvxEGYb
         AToA==
X-Forwarded-Encrypted: i=1; AJvYcCUY2I4z20Y7mKn+wrMeQvGVkq/b0/OfX+koZ45Qp7e9oihvsZQ28FmobEQwY8qmbyffQADldTy+Q7Po2CPq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PfGfEcvLJ1wdrJr9qCoqq6UON/rDVfDwNWAZcTmp2WhppaUM
	IDLD9raeZB0/G83v1upG9Kk94R/dBgK5fts9cPbVJU6AtnlCGBNn4Vyb
X-Gm-Gg: ATEYQzyp7CsKnxd4VImYblxxIuAli89DLX2bqWfyE94p1NaqzDCyeX3Zs7eX+AgheCK
	Cjb7gaA8+CKRK7PTwsqw895Qg7H+Q6v51R7EB9GAnqlh1RtGIylqNE0IS/dLv+o5wUSiEq9FwN5
	v5hmTj5qcrT1OF2gGckkrxPRziKYYRowomK1eDxgypC8e5szl3sCjLH/5beRDIgqWSz8AIEQudB
	7INzGmuz4gOq39Ke4W9MWJAXaqKLupjZ+obZFUjp6pXh07kNwK+UiqtCiGtUyia43SScZ0C0JIx
	z0hXR7cwtfrnOYn5evOvL7CbRDbLSO1Eh+K3AYKt2zm49C5L1CbNN5tuL/cKRBrudVXKe0FLXZC
	oGNZa9Bs6NjJmy4On632SbV9YyrW6pZOa+Yb0t2kwuKBuWdJz2zpJolSeViW+tCug61XjMpUP1+
	AwVLkp5mN9nyK8vDUTd6PF8KYrZcfqv5zclklUBzO9ditDZK5IVmMia6S0fhRFgWyraHjHf4vO0
	w==
X-Received: by 2002:a05:7300:640c:b0:2b7:95d5:3a32 with SMTP id 5a478bee46e88-2bde1b4dd2cmr411625eec.1.1772149665577;
        Thu, 26 Feb 2026 15:47:45 -0800 (PST)
Received: from localhost (99-122-55-39.lightspeed.sntcca.sbcglobal.net. [99.122.55.39])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bcdd95sm2776586eec.6.2026.02.26.15.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:47:45 -0800 (PST)
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
Subject: [PATCH 7/8] samples: rust_minimal: demonstrate early_param usage
Date: Thu, 26 Feb 2026 15:47:33 -0800
Message-ID: <20260226234736.428341-8-thepacketgeek@gmail.com>
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

Add an early_param annotation to the test_str parameter in the
rust_minimal sample module, registering it as "testing_early_str="
on the kernel command line.

When the module is built-in, this allows the parameter to be set
directly on the boot command line without dotted module notation:

    testing_early_str=world

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 samples/rust/rust_minimal.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index 59955e95e31a..9fc0c0a864d3 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -35,6 +35,8 @@
         test_str: string {
             default: "hello",
             description: "This parameter has a default of hello",
+            // This will allow the arg to be used in kernel cmdline without dotted notation
+            early_param: "testing_early_str=",
         }
     },
 }
-- 
2.52.0

