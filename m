Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYSMExc+"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB4D8;
	Mon, 20 Nov 2023 07:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700493265; x=1732029265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y1Slo391/qaxM0yM/Z69wR+ZO7w0aji/XOiyHktSsMY=;
  b=AYSMExc+rUGK0fyrmNWOm5eSUslfzy1/7sA45yHesCNF7cQUlBJUTH4E
   WU3SddVqZuXtca7s9/ZMiL34+Vd2oqJaRWOX5OKn0ZoP7ulI4yBbx8gyf
   EhkGSlU7EQsbjoDgD05WAVaUG19GGJ/jkjRfVdt0B4GLMs+4LFhmCz6ZN
   gXgYlMsyCUSFiXbqrkNYuRCc1Rsdd6hMPfDauu9KoPm7q4JXjKlBdhrf7
   l4MK39bySJCHXKY5LIV5qpyMCOWIgwRobRBEG7fR7HDDniuV1+l3KWfZJ
   /vPEd7taZDsUnk35sB2I3yiQQGYIN6E5sVp8fH3YauxgEzffexe/CaooL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="394486342"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="394486342"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801209700"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801209700"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 07:14:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 490A168; Mon, 20 Nov 2023 17:14:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/5] params: Introduce the param_unknown_fn type
Date: Mon, 20 Nov 2023 17:11:42 +0200
Message-ID: <20231120151419.1661807-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
References: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new type for the callback to parse an unknown argument.
This unifies function prototypes which takes that as a parameter.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/moduleparam.h | 6 +++---
 kernel/params.c             | 8 ++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 4fa9726bc328..bfb85fd13e1f 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -385,6 +385,8 @@ extern bool parameq(const char *name1, const char *name2);
  */
 extern bool parameqn(const char *name1, const char *name2, size_t n);
 
+typedef int (*parse_unknown_fn)(char *param, char *val, const char *doing, void *arg);
+
 /* Called on module insert or kernel boot */
 extern char *parse_args(const char *name,
 		      char *args,
@@ -392,9 +394,7 @@ extern char *parse_args(const char *name,
 		      unsigned num,
 		      s16 level_min,
 		      s16 level_max,
-		      void *arg,
-		      int (*unknown)(char *param, char *val,
-				     const char *doing, void *arg));
+		      void *arg, parse_unknown_fn unknown);
 
 /* Called by module remove. */
 #ifdef CONFIG_SYSFS
diff --git a/kernel/params.c b/kernel/params.c
index 2d4a0564697e..626fa8265932 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -120,9 +120,7 @@ static int parse_one(char *param,
 		     unsigned num_params,
 		     s16 min_level,
 		     s16 max_level,
-		     void *arg,
-		     int (*handle_unknown)(char *param, char *val,
-				     const char *doing, void *arg))
+		     void *arg, parse_unknown_fn handle_unknown)
 {
 	unsigned int i;
 	int err;
@@ -165,9 +163,7 @@ char *parse_args(const char *doing,
 		 unsigned num,
 		 s16 min_level,
 		 s16 max_level,
-		 void *arg,
-		 int (*unknown)(char *param, char *val,
-				const char *doing, void *arg))
+		 void *arg, parse_unknown_fn unknown)
 {
 	char *param, *val, *err = NULL;
 
-- 
2.43.0.rc1.1.gbec44491f096

