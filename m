Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D03A2576
	for <linux-modules@vger.kernel.org>; Wed,  8 Jul 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538954; cv=pass; b=dAYfAt8BRK3IaftbzWbBb1We0akmfQheLHUfeL3/C/j9/7pAxGCEjjoB2DRPbaF+n5QEBShRE3ObW5p22rSwOAak49P+L49/QuNGyUf0hmV06DegseMfFuQG54a2sl1Lu6CopMkMWqHwdzApG+x4CkXhLIFEaPngSPXDaDyjzLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538954; c=relaxed/simple;
	bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8tHLPuh3EBRmYs3QH8sHsIL1HLBW+UrETtZDS5mm3n7kNI40IrR5Xh1r5S9StdrzpbXoidq4X3zNiOzpco+2N05mhLr+fX+8uYeBS1lgrgiC75KUJrFIMFnyLKbKurFOyyoQUG3gR8i7NU/hznLLXnsFqYC2OiHlkb6ZR5z9QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrtyeo5D; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrtyeo5D"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6662551100bso226498d50.0
        for <linux-modules@vger.kernel.org>; Wed, 08 Jul 2026 12:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783538952; cv=none;
        d=google.com; s=arc-20260327;
        b=NBp4TMsNMURSLOhqHGKX3fkPlukCno5noyUZCqO3pzb0TtZEqh+3LpHMmMuXvT/fN8
         6U/x9a7vh54Jc7kXdSQJEYxfvdgx3and4+u0/NYrtq+KuiIHMa+kwUkYDGKiyoDC7hqR
         h0kROds29o6b4yCzM7+QY+Fv4OoOdEd6n13G2W0odr3J0+A/46G/CRMgOZYWFKW2VxkK
         +ywB6ncfay2kZUCIcVb+vGsbqQAtCKZF5r9EeHovGhiJ6IulnuCgVu5f+j+COswYiPNq
         X3D8S1uiuDEbQrxjBgSSKAEMfrSt9F4Gjo0mmRc81KpU+G++8GOgAeXCSaS9dzP7naCC
         7Uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
        fh=5cs6b6d7Xpq2ANmcE1sW6J73OLOoOdfaXy4E0BsYxz0=;
        b=jrXJuK/NHBRswV2Rs2Zn+eVGFwHwt1nGap6HVkkR+BZXmVchx2a+U+Jx196wczN6FG
         07iiiMB/2VTeTzqIl5SugG97ZD/bVN3/448VWOwcU4gQORppxjTCt8dhq5aya3rB6S9M
         U1TmMw43Xnq02abPYF30AZTZEoBaQo6W7P4YwT2dVLcTyTUmEk5wnGwsO0y4m5weJdJE
         Bf90yK8eJxP1Qz3V/Vqzj0VxckCUc0AR0l6/lsSfeetfIuSGdBVDtGP8YnAADsrMNRES
         U80SPCaw9q0OiOSwu+Gb5liD/9++TgNHDSjDE3ggVhYM4FFGrPAhDfXPjwHVW7Y+yexO
         LPQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783538952; x=1784143752; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
        b=Zrtyeo5Dn6rbI2V6sJdtgOYEoYlabL3nTMSUtKPH20BhgP3frh/oT2/MoifJcwa4wL
         Nj3QoWtyyoGNdXpnp3MLEZyBglnb6XKarWDJh1nS+VxjgmVieQMuY9mhwQ+w8ll7RiHh
         H7ggTJrpmlKyHkWdylfi8kM2B7uLVCsbeo0FEUEaYOTPi+7b/Ii0V4MyA87zD09mVKlm
         /ROQnRS1VNo4jRI8T+71sU/8K9OM4i+ezOK+mlMwh1swtWgTKoKI66vMkDTKxx/F94rp
         2DYINwX5C5RhVLrwza7fkHTwprLE5MSe/N5DtL2hmFX2w7yqg0u3lLMxh105qI7oG3iu
         34yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783538952; x=1784143752;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=esUPZMaeDhSEKuB3vyh8QdBpdwB8JbRv1S8jpJLODZU=;
        b=LDIJUEGSoj3l4CEcmgC5fn6cuG+70LedxH3QDij1tmQ1yQfIePIoPzEAEouQyDK/Xd
         3dCKuUMK0r74hBhRqBanfXblbxfuX+9icDNm2XpuG99H5VI5mqjIQrgEr2xZgEjbs84/
         nb8tAZRBGso4wZ3l0YFAHbjSQtRfNLx71iXVoNHMxqwaNTTWtupQ2ZuDcR6s5DES5V4O
         0Jc7SDogODvJNAM7+tL93JfscRvx6y2CV63/bw7Z3/2hxA5GCWWq6WHtTOxu3k3+/t1w
         DbELqqyGKq35JlgpGMryeGbeSjOy+A/lej3DcRTg3xivP+xQiPjFrXsC3qjfjjIdn8rf
         hHBw==
X-Gm-Message-State: AOJu0Yw+7Zrcc3XESasCEdUNMio5zELrOdwsQPEzCuuOZddMrgjInIDa
	FvhFXgUGMTs9VP1AbgEueLk8MKoHsx+G1lwiDbq8DlLlzAqRTZWWr0IdVkIv3qft1/K8CUN6tAG
	wrcON+TZWCbGJ0w+e14dl9N8R4fQ9fTddnw==
X-Gm-Gg: AfdE7cnX257koqEUWi4YF8Gl+SDRRgu23M+DGtELBfD7wqEas1MKHZJ/wH7HXpp/Vkk
	d9Fmrb7ZpAz6qSDoLoeMGSqrgV0/ZMqckjtY4FGs+T1WbqavmF4Ozltzmz9xxgrvTOHxy/857t+
	4iT0Qok3h/DMsHEhr6iJexy/zfi6rNQzMQg8hjhPbnrl2pY+QMaNA1Oz1pXGIRgUurQ8REMn7bI
	ENe+JNWcH+HWEc9rI2QirVq7zBJlNbuPM3NgYp36NcosN8lPszyLRLhUGzcJ+zzc/7Dhw==
X-Received: by 2002:a05:690e:4803:b0:667:648a:d05d with SMTP id
 956f58d0204a3-6679f0b6cb9mr2240010d50.39.1783538951867; Wed, 08 Jul 2026
 12:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-15-381f3edb0045@gmail.com> <20260708022913.E3D9A1F000E9@smtp.kernel.org>
In-Reply-To: <20260708022913.E3D9A1F000E9@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Wed, 8 Jul 2026 13:28:46 -0600
X-Gm-Features: AVVi8CcGWf-yvZRaz7uKpbWe3R_UDgHW5F3UfrE6h9rIgLwMf_mAYfqNisNfPwY
Message-ID: <CAJfuBxykm2wyG+UOvYqjO_uJBuo52ArGApHn2nmgRu4i+WwccA@mail.gmail.com>
Subject: Re: [PATCH v6 15/24] dyndbg: refactor param_set_dyndbg_classes and below
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hello,

The concern regarding old_bits in param_set_dyndbg_module_classes()
appears to be a false positive based on a misunderstanding of the
initialization order.

This is a sysfs parameter callback. By the time it is invoked, the
module has already been probed and ddebug_sync_classbits has updated
the module's pr-debugs to match the current parameter value.
Therefore, the global state (dcp->bits) correctly reflects the
module's state at the time of the callback. Using dcp->bits as
old_bits ensures we only toggle bits that have actually changed; using
0 as a baseline would result in redundant queries for settings already
synchronized during the probe sequence.

Thanks,
Jim
