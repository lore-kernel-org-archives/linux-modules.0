Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50838CFF5
	for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409791; cv=none; b=jFj/GDq1ZrYY3Hd7FuPWyyx5hkFTR/HZTV1yn+fJol6LFC0KCloqsMY9wsfw3/0r2Z8+/zE5UcJ4ge3L3Nk9uYucj5Oo5wValXzfU4EfhTwbbPrgC9HMVUCA0b0VR2X6DD7GiAfIeGqUO9uJNv45hO2NFglbZNeZl4oZwLygqTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409791; c=relaxed/simple;
	bh=xlmQ3qDMzvpdpMifhJ6Anh93+euqAxMJmpGAKMOuu10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuvEVItpUE7yN11cd4OZ9vUj87SdnnCelIOtMRMxZIAipoxlFeG9z/U9O8oy1s6HQ1DAFOBAXEhDg473L323qPL9AqyFm5VHIQbeJzAwPp55oe2aHRwzgRB7QUqYkyaYDq45qeUKas0e6Fem7KyDxXcjjwlsjAJUzdEYO4GD8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=daEi+si5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="daEi+si5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so25386625e9.1
        for <linux-modules@vger.kernel.org>; Fri, 13 Mar 2026 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773409787; x=1774014587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bphY2YyBdum7UF8/btyrmh1KWiawcs+qdIGEesKpiDc=;
        b=daEi+si5DbjIfVaZnxFP/K7boJiUh+S6V2CrJfs2AN9j2fZWgpA9QXQq4GhZNQJQxp
         e9eB+1FoDTP9TpvVpn1egWOzoS+R40q01Tif0pMv9rfQDLCGUWgcM48AVkfC00WgYcSQ
         maMkmek94TU9JREfa77InS4V2p9kj16n07Mx2vHGOz12S30NyqnZ3H9/W3yI5oXJQEpO
         UFwDZf1HYFvRUacTXcPbZPl4nzDUu2JPZuvER0kGRDHv5KN5PiCVBwwbhmVb5FwpE6oU
         3XMkg4DRgEfZIzgz+1HiwAggAlhaxPtwWprhDTmITxb2SwZeIGs4cRiqJaB8JMSWCAHi
         vIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409787; x=1774014587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bphY2YyBdum7UF8/btyrmh1KWiawcs+qdIGEesKpiDc=;
        b=Xd4JIS9BHogj5sd1Lpf2l0G0l9KwrnhRnCQ+UacgkrPwtf+SVWvij2qXfsAAn5Jv89
         s9f4oep0Lpv/DfEEE+5/XFzMAby55xfcDgqYF0+HQZPftROwVJb76sxzfxq2wypkPse2
         SBLgylP8GFrDOTX3iwL4eQJz215XrDvr1x1acWi4GI9vwNgP16lNim6AKg1D5HQPWacb
         cPUh7JDbZu+MaC9ePxZMZf2MhTDE9XZ6dDAZXD6yE7CPWl0eRMTH2o9GwXCBHKjN7eit
         M3T75TS02KAG4hrcSgCKkwu/oBx/w5+KqeKCFcqtj+fcb76U4cWLrQetlbuSat7NYOcA
         iqig==
X-Forwarded-Encrypted: i=1; AJvYcCXU/CBIL4TF2bUpdlFcDFp46Qqf/+iaiTKPLq/ZBOaOEwpK6syg5FtupghdGGBuEEP4H/XOtBvqbFBfKWTH@vger.kernel.org
X-Gm-Message-State: AOJu0YyogeXmAKNaOrwAxAGzB2+PzvtCHJCHpWPp8r1TM8qkmf9lzYAZ
	wNw2U/rlAO0HYsquTn9RXGeJSDjkQqrLKCCjpYca7/ZxKa6KuaVwEYBY25Jf7ljtqT0=
X-Gm-Gg: ATEYQzyXCWdB/Fbw1My/XcOdD+sxyo1JA1BM9Z2UHhn7xDQi5uXpYLjAtiRttZOc7Wu
	kkhtS48I8nmtUKf5+zgAwT6e0HSDpfTLks7kf1YUeqnMhU5nToOR6ssGqhT5bWx6CK6eILC3S54
	9HbqQR9iABiI18db2s24NWewnUjTwZvwbVXuQK/9WmXr4iTTf33Y9xLmOR2g3vJItEVM1MAH01N
	oy2/AbXyhkKY9zL+p/oGsGiXH5p7z2o0y3b30CvJiuUXk+4zajUuLajL+srSzdacue6rlQptpvB
	mMB0bCqOGNVU/84GvKSBSLW3i8+HXeDR0eRc+gncxXxylczCFTO5PwIE6of5pdQa52MNzkbCpcv
	ZheJnXArt8plxxFQQ24zJFtCtIpc3gA7D3X5tYwP4Ss/eVYSVEGx/yExRDkz49h4va3JuOgVoht
	/Oh3d054CEqjsIZ1BCdmMWoBrvpES4duRp6KrxeVfY
X-Received: by 2002:a05:600c:8b6a:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-48556711e74mr53911955e9.30.1773409786636;
        Fri, 13 Mar 2026 06:49:46 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm206491865e9.14.2026.03.13.06.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:49:46 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] module: Clean up parse_args() arguments
Date: Fri, 13 Mar 2026 14:48:03 +0100
Message-ID: <20260313134932.335275-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313134932.335275-1-petr.pavlu@suse.com>
References: <20260313134932.335275-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Use the preferred `unsigned int` over plain `unsigned` for the `num`
  parameter.
* Synchronize the parameter names in moduleparam.h with the ones used by
  the implementation in params.c.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/moduleparam.h | 8 ++++----
 kernel/params.c             | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 8667f72503d9..604bc6e9f3a1 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -417,12 +417,12 @@ extern bool parameqn(const char *name1, const char *name2, size_t n);
 typedef int (*parse_unknown_fn)(char *param, char *val, const char *doing, void *arg);
 
 /* Called on module insert or kernel boot */
-extern char *parse_args(const char *name,
+extern char *parse_args(const char *doing,
 		      char *args,
 		      const struct kernel_param *params,
-		      unsigned num,
-		      s16 level_min,
-		      s16 level_max,
+		      unsigned int num,
+		      s16 min_level,
+		      s16 max_level,
 		      void *arg, parse_unknown_fn unknown);
 
 /* Called by module remove. */
diff --git a/kernel/params.c b/kernel/params.c
index c6a354d54213..74d620bc2521 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -161,7 +161,7 @@ static int parse_one(char *param,
 char *parse_args(const char *doing,
 		 char *args,
 		 const struct kernel_param *params,
-		 unsigned num,
+		 unsigned int num,
 		 s16 min_level,
 		 s16 max_level,
 		 void *arg, parse_unknown_fn unknown)
-- 
2.53.0

