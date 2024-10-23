Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEC91CC154
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703287; cv=none; b=OzmmZ8U12CiAO1a5BGZNnsmeYGHdSxOzZA2lGOsogxvRYCxtT2NAYYhiHUIPqPvYsaDxJ01XoU4iyTfo2laUrQOBuo3NMAVO1Y2JvVHW3wCUZEKDa8s98pvZ40kDn0FKAiOuJEgcOp6h/fNXcA86Pjf0heVuM1rXXEQ1vPo5BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703287; c=relaxed/simple;
	bh=oPiAZk7sAUwyc2ZRzUfKOKHVYouPvs61/fhZTZAzOCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNYvNSIdTZ5WSp6P6z1A3fKvEDsf29d8ebZne5kREDCx8MtNcIeCz3rXiv9b4bDG0YIzqG1kJ8w+PzbJjOJ9H6SLmwbDr4xBLkLx8mQf9G8E/qTJnyseSbq6CHnkVcusipzO9NhaWegRgXRkvNHQGee7weNPY+axJpjqMqWS79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qx652BjR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qx652BjR"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e297a366304so20881276.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729703284; x=1730308084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy4VkAGTnueEjEvw1TSjR77Zk0lX1faSNj+Oljrwa2Y=;
        b=Qx652BjRJlLBDhiwtgP7rFltqcVCeOz64AMfJMi1lfmNwRT3W6yJF2h66vz/NOdKvE
         iZX2r/6r71iZd3H6wP+kW3t8a0HXMP2YOsXTg3tOJAbvPBlyVSndmovQp59wBX4nnbV8
         jejqeBwwjT7qIeRe08oGq0Cp83lM1+FOvt43wByN6sfYVEa14DIljwjJONrccZ7wFFHv
         fZNNV++nuuSoZIeX9NJpihOasG9IF1MQ4QIyGQFQJs0TmnWguyVWNAywiZshv+JiuOUm
         SH/lNNTmYiapZtyvrkKBGRczlN8UQ2w9m85DNYwABykAZaiWY/T+pOmFff90ZJdc96hQ
         4Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703284; x=1730308084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cy4VkAGTnueEjEvw1TSjR77Zk0lX1faSNj+Oljrwa2Y=;
        b=BpwRFUiG3cHWK5mntpMuIAhZrbsk4ggK50U2A3hIzzVDKaDa1BOam+wfQ0ctMwx8Ia
         0LduZQpnQT5wsuQJjs+hyv8xlh3Us6i962OH8zvvR3NHm6JL5UKqxKtxJb5I78s8l12c
         1qynnnZTovBNdzMU2gh+NyEgOC/kdlgZQShfL6sM+1xWzYybVHFHcuHpHR+AVgQdBk6p
         oUB4Otl35gs5KEJvWTyhmg5M3/iX82ttIF4Z81X4uCf5y03JrL7bJ/q9+h5ic+hcQYcB
         giKhORc8jtsre3/AF7zoijqkWvCvRQNcOJZxE9uhWzDdfn56s8lvwkP17I1aJsC2ybqR
         PoXw==
X-Forwarded-Encrypted: i=1; AJvYcCUKMPoGzNiLqfm3FZVeW/chCBYRTp7VM3K57bvzk2JWkmIrCjiPoTdnTPJnMkC2Nf+bdWbTVbzGrbdsjBRI@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/DDo/3hFNyoSLdeUpQaeS+zx1IxHyI8AtxaIat0yN1dxl3Up
	UxqgjhgPEXjsxR/yf0CC3OuXj73NdXL+jyfGpUIVrUmrGzyXLLTni+oXFY5PI1rJ+g4nTKV76Kr
	UXQ==
X-Google-Smtp-Source: AGHT+IG5P3EOBq94xAhs93OihXu6fn1+vh8Hj0b9Xh0nro0ohDjLm9Tm7P85Bm8yXiSBBXuIOUCegUy3OSE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:a087:59b9:198a:c44c])
 (user=surenb job=sendgmr) by 2002:a25:7241:0:b0:e2e:2b0f:19fc with SMTP id
 3f1490d57ef6-e2e3a631bf2mr3476276.4.1729703283882; Wed, 23 Oct 2024 10:08:03
 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:07:54 -0700
In-Reply-To: <20241023170759.999909-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241023170759.999909-2-surenb@google.com>
Subject: [PATCH v4 1/6] maple_tree: add mas_for_each_rev() helper
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Add mas_for_each_rev() function to iterate maple tree nodes in reverse
order.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/maple_tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 61c236850ca8..cbbcd18d4186 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_for_each_rev() - Iterate over a range of the maple tree in reverse order.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__min: minimum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range for the
+ * entry.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_for_each_rev(__mas, __entry, __min) \
+	while (((__entry) = mas_find_rev((__mas), (__min))) != NULL)
+
 #ifdef CONFIG_DEBUG_MAPLE_TREE
 enum mt_dump_format {
 	mt_dump_dec,
-- 
2.47.0.105.g07ac214952-goog

