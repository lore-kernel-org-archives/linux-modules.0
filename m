Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968E85949
	for <linux-modules@vger.kernel.org>; Fri,  2 Feb 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900921; cv=none; b=N/M5GxibkiHYXvF/UhH/V4gzd5S9meGE7HUvc93ULiHNJZjE/zcwfHVlF8V2uDTbuYdTnMSgD8C6Pfqf7pf2knBiqGM4HXN+NDDnNdlmxU71SL9MuzbdM+8zmMOyR0MU1xknVZ6yUwKODWrC9vKCw3kW9LDLZ1NQAkIpdRcP/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900921; c=relaxed/simple;
	bh=57aGhS+cTC01sveMXFs0ThdUt1RffGFfGPtbeVgKPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0thpIkCbS7rJsQ/ZLnyWjWPdNW1uDHGXaaVIEkKUezOGLCceZOMtiDB/bAeYeu2lkeXPjO1MV4OxE6SzhBIGnmIcWyHavkcroF1tYqBk4i7ftkrU/z16nF0+VA3CWA8MihTNNQhyQS2D+vPNfuUY/DgDDAclfEXsBU2tqpuuig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTlKjfx7; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTlKjfx7"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-783045e88a6so160533085a.0
        for <linux-modules@vger.kernel.org>; Fri, 02 Feb 2024 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900918; x=1707505718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSSaESztnTk2lOsQbVLyfx9ZpIgh0wOgu12Nu54ahjE=;
        b=VTlKjfx7WqgITQ2EKstMfqddD5kWvgWKOKmsM6ec3xZ75NUKgdKa/53um80mVonp1F
         HkqeZUylWPaDvwZLT6BrBcQXY3/KaWhw9cFZhOG0dMi1XQ8vhOwi2FGDXh/VTBrtu0Vu
         hQ62icDCaJX/cYQ+lQ9HEiJ6BhNJ7MZ+F6tFN02UoK/S0jO3ttkHeFodn7Ha6b7wSglm
         XEtffBWJKt6E3LsipWsr584A05yYyU/e9zjyqhYN2JmBJztMaRHQ0z0Tvn/sqYbnNKLC
         Y6wDAiTpM9iUmKrd/EykVDgn1aXSI5X6X4uhYJqXNFx2BGjpDhzshI9xM8Hf4LYb7UvV
         Uk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900918; x=1707505718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSSaESztnTk2lOsQbVLyfx9ZpIgh0wOgu12Nu54ahjE=;
        b=TtDFNc7n8TZ1A/xG1UY+/odTOALsHjCwIKqpzmo1+DxVR/pDolo2Fjo5cgF6A0AFsi
         f20tqJtcyCglg/edEBNW46ysg1XG8TOGxGUt0Cv5YXEDLGFoIobI/8BTwqcojwJIUJ+O
         ipXh0qARDDvW50pJPP59WLURnD80pSb7lOSn/2i8UOni8XDPpAX/2ExmPvHMha2QPc0A
         NTUKA1cWDiAYaX2IWY6vGp+o0VDKnFxYCxfrSME0LjozZk8gyh6969DBb/7cEXavfgIw
         W5QiSJmC6RZmsIQjrP9Xpx2Fp4DLLSybT2mrA6j3GEy+rQjORbnE2Y5KfOMDl/8kYz57
         aJ4w==
X-Gm-Message-State: AOJu0YzUm9YWUs+TqqOcNJudr5Gz99GRx6bETobExIu1az1cddnWSGy0
	H2cBxRmuMFaObspgFEmSWJtQ0EtsuYuwa56xVP2GBgSlL18abHc1VMgygkkN
X-Google-Smtp-Source: AGHT+IHRSnmaGdTrxYVW1BcI4GU1q17p0hMPr4aHcJ5yS0k/iJIAgtTJoKNaF57vIzRqA+hMEyL2gQ==
X-Received: by 2002:a05:620a:84c3:b0:785:5ed6:f604 with SMTP id pq3-20020a05620a84c300b007855ed6f604mr1349298qkn.9.1706900917659;
        Fri, 02 Feb 2024 11:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUYVb1r5WnsDadXDGQa9vGtF7mDc2XbY+3ZXhsy9yUD1lkMUk6gSgEZCVg87RjMaAE25dlgpjCsUGINo2EwU4DKaCJih+T3ELg=
Received: from ldmartin-desk2.lan ([192.55.54.51])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a15a400b0078408de98e6sm903011qkk.72.2024.02.02.11.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:08:36 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 4/4] gitignore: Ignore *.pc files
Date: Fri,  2 Feb 2024 13:08:23 -0600
Message-ID: <20240202190823.418148-5-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
References: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tools/kmod.pc is generated by build system. Any new *.pc we may have
should follow a similar approach. So, just ignore from git, like we do
for e.g. *.o.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index cad86ea..29b3102 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,7 @@
 *.o
 *.gcda
 *.gcno
+*.pc
 /*.tar.xz
 /*.md5sum
 /*.mbx
-- 
2.43.0

