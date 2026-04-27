Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C4274B2B;
	Mon, 27 Apr 2026 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277595; cv=none; b=hUBpUdzpGJMxK4LxEDgP3BI5VX6MZMsMiswqaA9R94cBGpaN888Cr8r1qHq1FhSiCwXaw2Zq0XIirVnyBG4JqxKfBuR0JW2f7Oe7GGNkyLXooLxxTJ32IzpIDNX87nxTOBhRO+lJ+9Prob/eQsbcx6AkyKsnc8f6dDppFKDGM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277595; c=relaxed/simple;
	bh=J4FdivisA5i6CVm22L4aF+rdY/qvJxgfLL0+RyfTNW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gRx1Iu2iWKw3BEulNqtmz4uY4STAOFEWdx1fmmsnf6bDTycurUzkHIqMQ/rbJsXVrPgBA1Yevcpls1CQGMux4SkEoPDCDvw5Xwc9LeSr6RggIayU364iMoo2YIFzBFuTjso6XTrzv4GTMkTvCfM1jSu6w+j8uQObF+EVqAKWAsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOfxd0J9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOfxd0J9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD09C19425;
	Mon, 27 Apr 2026 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777277594;
	bh=J4FdivisA5i6CVm22L4aF+rdY/qvJxgfLL0+RyfTNW8=;
	h=From:Date:Subject:To:Cc:From;
	b=mOfxd0J98GtdhC3oLxJJBees7XkgS+fNrmKtFSG9FZwHFAifco8wJlAnKoPur/92C
	 culQnm70vYVCNJW28M7XjSjPoscimQuioz0+wLE2Ovu3qeMkE8XHk4m3H+4Awt8rU5
	 xJ4rmL9ykp2v4hq6yJw5ZEkeZ+/injSz23T0CPcKd8tj3qjQAEwKYE+KeSzKOIUkUG
	 6LEIgCpZSHITTbqdUIhHc7rd2GakvYawpp/wYZrhwRNpSaGjqzIDFZY79mBmXeniqG
	 QNHaRm4P6GaU5gk2UXU+SCamcdb+6tAosYBF0b5HBGp/8/n8MX78ItLla8TwLe9/k2
	 kYmr7y2xBkYgg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 27 Apr 2026 10:11:35 +0200
Subject: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer
 warning
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
X-B4-Tracking: v=1; b=H4sIADYa72kC/x3MPQqAMAxA4auUzAb6IypeRRxKGzWDtaQggvTuF
 sdveO+FQsJUYFYvCN1c+EoNplMQDp92Qo7NYLUddG9HzF78WTALXikQ9pMJ2sXNkfXQoiy08fM
 Pl7XWD2i4cv1gAAAA
X-Change-ID: 20260427-params-pr-once-481c03df3e2a
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=J4FdivisA5i6CVm22L4aF+rdY/qvJxgfLL0+RyfTNW8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBp7xo8aBkqoqG53iMsq+m9tX0rmw1MIGC2jP9Ek
 VWghOme8XGJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCae8aPAAKCRDhuBo+eShj
 d0lLD/0TZAN+hG7ZYYpmLU4GkpqRINliCt7PmFBBeZfo5DspKCRD8eB+OXgUMsyjVa0EQx0TrU7
 r4ydokUlFjhlVfMGBGbZ3CuAtrGzd+8v5LXv70OWIopp9aDgKqG9jvekAyG5+9C5cVSpHj7XnsT
 KWb/G6QFq3JwuTzfQX134WbZXu2+uQ4UOPjpUzPw+XPySvpRc6GWwd8hYKBDbeIw3o0QeF8qtyt
 d7VwL+kg5uRO/VkHyac9mT5OL5xEP5FizTcYU7rPdpimM8CN48rBJbR6s/IFQFWLHpKrAtGwYjP
 FMWpQ6ERok5eK7uHdvKPFh8Z9rlDkARNhil9h0VynYBLV6V86muE86VNmuwxeFrl0VnPpD6gMdi
 9P13xF//+GD23WmwQR3f/9il69PY8QpZTQMvuJfL/fxR0/FRMiHSL0pTOSrSB5FW4NE7pOTYtjh
 yXrnCdvtnAXX6gPSUAErHeDaKjLX8EhWc1EV1tSyAqKdiPg13FoTa92nfyWKr6ElRuUeYp3K+Jn
 aZ81KIXsDWVEZ4z3cZFkBw9jS+IpDhxwXJRQZOApm/bVV7HRmH9ZUufdfi5/ficKIyNiKdtcUEC
 ATTMXJzgNT6Y0l7pbcDeRjsIwhdLlQyyDmYm76AmnLk3YeL8gOYZazQ16dMDS/Go6iH69q/DPay
 XXjinKw5uNviUkg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Replace `pr_warn!` and the accompanying TODO with `pr_warn_once!`, now that
the macro is available.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/module_param.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index 6a8a7a875643..dd6d663a0a3c 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -62,8 +62,7 @@ pub trait ModuleParam: Sized + Copy {
     // NOTE: If we start supporting arguments without values, val _is_ allowed
     // to be null here.
     if val.is_null() {
-        // TODO: Use pr_warn_once available.
-        crate::pr_warn!("Null pointer passed to `module_param::set_param`");
+        crate::pr_warn_once!("Null pointer passed to `module_param::set_param`");
         return EINVAL.to_errno();
     }
 

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-params-pr-once-481c03df3e2a

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


