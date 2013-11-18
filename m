Return-Path: <lucas.de.marchi@gmail.com>
Received: from localhost.localdomain (ip-64-134-188-214.public.wayport.net. [64.134.188.214])
        by mx.google.com with ESMTPSA id u52sm27473992yhg.5.2013.11.18.06.05.15
        for <linux-modules@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 06:05:17 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Subject: [PATCH 7/9] array: avoid duplicate code to reallocate
Date: Mon, 18 Nov 2013 12:04:25 -0200
Message-Id: <1384783467-23476-8-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
References: <1384783467-23476-1-git-send-email-lucas.demarchi@intel.com>
List-ID: <linux-modules.vger.kernel.org>

---
 libkmod/libkmod-array.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/libkmod/libkmod-array.c b/libkmod/libkmod-array.c
index 8417f9a..1082deb 100644
--- a/libkmod/libkmod-array.c
+++ b/libkmod/libkmod-array.c
@@ -28,6 +28,17 @@
 
 /* basic pointer array growing in steps */
 
+
+static int array_realloc(struct array *array, size_t new_total)
+{
+	void *tmp = realloc(array->array, sizeof(void *) * new_total);
+	if (tmp == NULL)
+		return -ENOMEM;
+	array->array = tmp;
+	array->total = new_total;
+	return 0;
+}
+
 void array_init(struct array *array, size_t step)
 {
 	assert(step > 0);
@@ -42,13 +53,9 @@ int array_append(struct array *array, const void *element)
 	size_t idx;
 
 	if (array->count + 1 >= array->total) {
-		size_t new_total = array->total + array->step;
-		void *tmp = realloc(array->array, sizeof(void *) * new_total);
-		assert(array->step > 0);
-		if (tmp == NULL)
-			return -ENOMEM;
-		array->array = tmp;
-		array->total = new_total;
+		int r = array_realloc(array, array->total + array->step);
+		if (r < 0)
+			return r;
 	}
 	idx = array->count;
 	array->array[idx] = (void *)element;
@@ -69,13 +76,9 @@ int array_append_unique(struct array *array, const void *element)
 void array_pop(struct array *array) {
 	array->count--;
 	if (array->count + array->step < array->total) {
-		size_t new_total = array->total - array->step;
-		void *tmp = realloc(array->array, sizeof(void *) * new_total);
-		assert(array->step > 0);
-		if (tmp == NULL)
+		int r = array_realloc(array, array->total - array->step);
+		if (r < 0)
 			return;
-		array->array = tmp;
-		array->total = new_total;
 	}
 }
 
@@ -102,13 +105,10 @@ int array_remove_at(struct array *array, unsigned int pos)
 			sizeof(void *) * (array->count - pos));
 
 	if (array->count + array->step < array->total) {
-		size_t new_total = array->total - array->step;
-		void *tmp = realloc(array->array, sizeof(void *) * new_total);
-		assert(array->step > 0);
-		if (tmp == NULL)
+		int r = array_realloc(array, array->total - array->step);
+		/* ignore error */
+		if (r < 0)
 			return 0;
-		array->array = tmp;
-		array->total = new_total;
 	}
 
 	return 0;
-- 
1.8.4.2
