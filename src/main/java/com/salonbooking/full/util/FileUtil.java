package com.salonbooking.full.util;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class FileUtil {

    public static List<String> readFromFile(String fileName) throws IOException {
        File file = new File(fileName);

        if (!file.exists()) {
            file.createNewFile();
            return new ArrayList<>();
        }

        return Files.lines(Paths.get(fileName))
                .collect(Collectors.toList());
    }

    public static void writeToFile(String fileName, List<String> lines) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }
    public static void debugPrintFileContent(String fileName) {
        try {
            List<String> lines = readFromFile(fileName);
            System.out.println("==== DEBUG: Content of " + fileName + " ====");
            if (lines.isEmpty()) {
                System.out.println("[File is empty]");
            } else {
                for (int i = 0; i < lines.size(); i++) {
                    System.out.println(i + ": " + lines.get(i));
                }
            }
            System.out.println("=======================================");
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
    }
}