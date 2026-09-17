Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5D518150
	for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667005; cv=none; b=iImD3QzV4adfqjCFOqDOvhtcxGeG0FlVKWMK7CK5rcUPwzRHZx6X9lpRiOEi/5f9XM6Sv9rwTZfkToNwuj1hfzBkSygI1G3Nrhd/951f4cfRrPCoZz6EZZo2eEpolKPyTZnzOPuYRYUmqT1OOJaiojxeCzf3Aq8+QOTai5PASTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667005; c=relaxed/simple;
	bh=xRIBk/+4aAdTisP5cPXKdrRiblMmTACWUkNkYGUGEqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tf0Pf1G15Ji97BEb7QUq3L3oVCxUwEvvX0Ik2MBPs/HT6aFZSKmyesb15OGUBJowg8cZMCoOfUduYeaic+Q+HzmUadBY790w0JoXorlcAUDdyC3pSPSKy+bWvctvRSlYvdFrC6/gQxnLTvbS7760bR3fWqZ1rjcn9JU9OjcDfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=WQyHlb/L; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="WQyHlb/L"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso10506075ad.3
        for <linux-modules@vger.kernel.org>; Thu, 17 Sep 2026 10:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1789667004; x=1790271804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTn/g/T+EO2MriuUGZpknmrePNwnpKu/d81Bl6mlyW8=;
        b=WQyHlb/LpyYQxb1ZROlvJUWDDWztMcD39XzPwteiVdqR3lmSP48T92lTTDSAMNPGgR
         g07uaNVsByAc0s4LDaiZ+90qKx2AjMgpndw6Mb/VLZJDKD2iO8cVlcEKsf0AAuX0Bllm
         rerSEXNppfv68FRrQFlPXw0hKVdR86grVtQStITkmAFbDqLKc7tmRWfuluIdEAocQJ9J
         LmgfSuGjscG2H985BJq0gfSYdydoMipvopaf3UkCQbtRx55g8XvqRVqVKpGGtGoas+9r
         9MP2Sln6QYtedid4UIi3WpQ0Yg+iuulX8xa3fSPBe6rTDV9IhCH8kS1sSM2aNdylYeN8
         wiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667004; x=1790271804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTn/g/T+EO2MriuUGZpknmrePNwnpKu/d81Bl6mlyW8=;
        b=sGs9JU6n1+GN0PNjvit4LskQkML79OGVZcGtzdinG0bpR6vcmlxEt5UaXXdMMRFV5n
         YJAKF6x1z8JdZ00m0e6WnsbXGCMRNCJfYIr4gVqBXkSFr9nxcuZhkmM4YJjPm//UXzNd
         Uftkn+uJ+phVL1fRXnuaCX5TN5rWLnrut2WxFYNGpLTO55s2kp7IeMqZ+VvZ1JHQO2vM
         8Gp/apj3ak97e3zsWr9Hyl8XMmAvNc4yIoXgXeDddZ1gshu01TW8ePLmZ3/19HQcDzD/
         Nk8tOL2Xy6mVw0xU6iOcd+YGUnUuqMOoz7MlpGpizWYzoYo2bixGgzpVc/phmyVuqo9Z
         x6KQ==
X-Forwarded-Encrypted: i=1; AKwUvByovKvCbh521OvIIIPrwOahLe6p7jzt9m95bcHgNKgbgPWuz2Vgr31JshMfVmnHAgNDt4ScutPK0MNOUa3t@vger.kernel.org
X-Gm-Message-State: AFuF++k7dsMuh1Egpf/hWGGHVwFcMR7h3zHwXmeJjN1yYCLJH3PY4fBo
	SZqCI4BaViSyu8Im2BPWSAofKPIZ1gpj5RUWhPhvrJV05AT6Dz3H4RDuxbKs3jmmdPg=
X-Gm-Gg: AYBFou1TmyFOIVM/ohbhURoM7LcuWovxg218f8UNGNgSwLXST8wAGUcRFgpBU/JoIgw
	MAwkSB7j3sCTXjFox2h8p51tXsxG9sDXiHrVVS9M7HqmRCc+E4vWOfu6vNFE1NQT+mDuUxYK6Xh
	Mbs9NNfDyeKCaYKf9K+wRJYXu4TL3uJtzNgmBpGPlI6sNRywDFZuZDIa6mkKX1Whhhfd9PKet7X
	h/KrgfaBKKi6hyNPUdS4zU6X8Fj8Y+c21TueshO1NuiurIJr7eCxs1PrR0XOqbmOpOesHO4dY+V
	f439KBjcIvtebjJVCrMET5gIjn3eyv2OKEg8odCCcgZGyHBpxMvbTE/LvUaqkKm/G4zDxiUrMrG
	OVI6qVWVuNHfmtt20w30CUYs/LAjvUtpjJxmsxZva3C/+qstlV42soZdb3rRERSmrx94k9s/zST
	++L3UhYbCA+cDcPteKbcwNBhCGn9nm5xfSPP9IKlf9yIpYKW5PVqRdppqmT278jXHwv0ARgtaZA
	UV+C0alHP7detwRbrn6dyqZKc22NWsCldi0
X-Received: by 2002:a17:903:3dcd:b0:2dd:ad73:5b74 with SMTP id d9443c01a7336-2ddad735d45mr13537105ad.36.1789667003705;
        Thu, 17 Sep 2026 10:43:23 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm19657730eec.14.2026.09.17.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:43:23 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	ojeda@kernel.org
Cc: atomlin@atomlin.com,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	pgovind2@uci.edu
Subject: [PATCH 1/1] rust: module_param: Fix potentially incorrect access of `SetOnce<T>`
Date: Thu, 17 Sep 2026 17:43:20 +0000
Message-Id: <e65203759411aeca4805e3f619f3dd20839dba35.1789426258.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789426258.git.pgovind2@uci.edu>
References: <cover.1789426258.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `set_param` function casts `kernel_param.arg` to `*const SetOnce<T>`
But the Rust module macro in rust/macros/module.rs initializes `arg` with
`#param_name.as_void_ptr()`, and `#param_name` is a `ModuleParamAccess<T>`,
not a `SetOnce<T>`.

ModuleParamAccess<T> has default Rust layout but `set_param` accesses its
first field SetOnce<T> assuming it to be at offset 0. This is not
guaranteed by Rust and could cause type confusion leading to data
corruption.

Fix this by casting `kernel_param.arg` to `ModuleParamAccess<T>` and
then accessing the `value: SetOnce<T>` field.

Fixes: 0b08fc292842 ("rust: introduce module_param module")
Reported-by: Dylan Zueck <dzueck@uci.edu>
Assisted-by: LLM
Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
 rust/kernel/module_param.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index f9a14765a926..7ae87ffe1d6b 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -75,7 +75,9 @@ pub trait ModuleParam: Sized + Copy {
         let new_value = T::try_from_param_arg(arg)?;
 
         // SAFETY: By function safety requirements, this access is safe.
-        let container = unsafe { &*((*param).__bindgen_anon_1.arg.cast::<SetOnce<T>>()) };
+        let param_access = unsafe { &*((*param)
+            .__bindgen_anon_1.arg.cast::<ModuleParamAccess<T>>()) };
+        let container = &param_access.value;
 
         container
             .populate(new_value)
-- 
2.34.1

